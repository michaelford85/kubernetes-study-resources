provider "aws" {
  region     = var.ec2_region
  shared_credentials_file = var.aws_key
  profile                 = var.aws_profile
}

resource "aws_vpc" "k8s-vpc" {
  cidr_block = "192.168.0.0/24"

  tags = {
    application  = "k8s"
    cluster-name = var.ec2_prefix
    Name = "${var.ec2_prefix}-vpc"
  }
}




resource "aws_security_group" "k8s-master-sg" {
  name        = "${var.ec2_prefix}-master-sg"
  vpc_id      = aws_vpc.k8s-vpc.id

  ingress {
    description = "kube-apiserver"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "etcd"
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "kubelet"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "kube-scheduler"
    from_port   = 10251
    to_port     = 10251
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "kube-controller-manager"
    from_port   = 10252
    to_port     = 10252
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    application  = "k8s"
    cluster-name = var.ec2_prefix
    Name = "${var.ec2_prefix}-master-sg"
  }
}

resource "aws_security_group" "k8s-worker-sg" {
  name        = "${var.ec2_prefix}-worker-sg"
  vpc_id      = aws_vpc.k8s-vpc.id

  ingress {
    description = "kubelet"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "NodePort Services"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Weave CNI TCP"
    from_port   = 6783
    to_port     = 6784
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Weave CNI UDP"
    from_port   = 6783
    to_port     = 6784
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    application  = "k8s"
    cluster-name = var.ec2_prefix
    Name = "${var.ec2_prefix}-worker-sg"
  }
}

resource "aws_subnet" "k8s-subnet" {
  vpc_id            = aws_vpc.k8s-vpc.id
  cidr_block        = "192.168.0.0/28"
  map_public_ip_on_launch = "true"

  tags = {
    cluster-name = var.ec2_prefix
    application = "k8s"
    Name = "${var.ec2_prefix}-subnet"
  }
}

resource "aws_internet_gateway" "k8s-igw" {
  vpc_id = aws_vpc.k8s-vpc.id

  tags = {
  cluster-name = var.ec2_prefix
  application = "k8s"
  Name = "${var.ec2_prefix}-igw"
  }
}

resource "aws_default_route_table" "k8s-route-table" {
  default_route_table_id = aws_vpc.k8s-vpc.default_route_table_id
  route {
    cidr_block                = "0.0.0.0/0"
    gateway_id                = aws_internet_gateway.k8s-igw.id

  }

  tags = {
    cluster-name = var.ec2_prefix
    application = "k8s"
    Name = "${var.ec2_prefix}-route-table"
  }
}

resource "tls_private_key" "k8s-tls-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "k8s-key" {
  key_name   = "${var.ec2_prefix}-key"
  public_key = tls_private_key.k8s-tls-private-key.public_key_openssh
}

resource "aws_instance" "k8s-worker-nodes" {
  count         = var.num_instances
  ami           = var.ec2_image_id
  instance_type = var.machine_type
  key_name      = aws_key_pair.k8s-key.key_name
  subnet_id     = aws_subnet.k8s-subnet.id
  associate_public_ip_address = "true"
  root_block_device {
    volume_size = var.cloud_worker_volume_size
  }
  vpc_security_group_ids = [aws_security_group.k8s-worker-sg.id]
  tags = {
    Name = "${var.ec2_prefix}-worker-${count.index + 1}"
    cluster-name = var.ec2_prefix
    application = "k8s"
    cloud_provider = "aws"
    role = "node"
  }
}

resource "aws_instance" "k8s-master-node" {
  count         = 1
  ami           = var.ec2_image_id
  instance_type = "t3.xlarge"
  key_name      = aws_key_pair.k8s-key.key_name
  subnet_id     = aws_subnet.k8s-subnet.id
  associate_public_ip_address = "true"
  root_block_device {
    volume_size = var.cloud_master_volume_size
  }
  vpc_security_group_ids = [aws_security_group.k8s-master-sg.id]
  tags = {
    Name = "${var.ec2_prefix}-master"
    cluster-name = var.ec2_prefix
    application = "k8s"
    cloud_provider = "aws"
    role = "master"
  }
}

resource "local_file" "k8s-local-private-key" {
    content          = tls_private_key.k8s-tls-private-key.private_key_pem
    filename         = "/tmp/${var.ec2_prefix}-key-private.pem"
    file_permission  = "0600"
}

resource "local_file" "k8s-local-public-key" {
    content          = tls_private_key.k8s-tls-private-key.public_key_openssh
    filename         = "/tmp/${var.ec2_prefix}-key.pub"
    file_permission  = "0600"
}
