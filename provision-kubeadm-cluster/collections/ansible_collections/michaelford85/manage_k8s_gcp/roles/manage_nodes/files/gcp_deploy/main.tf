provider "google" {
  region     = var.gcp_region
  project    = var.gcp_project
  credentials = var.gcp_key
}

resource "google_compute_network" "k8s-vpc" {
  name = "${var.gcp_prefix}-vpc"
  auto_create_subnetworks = "false"
}


resource "google_compute_firewall" "k8s-master-firewall" {
  name        = "${var.gcp_prefix}-master-firewall"
  network      = google_compute_network.k8s-vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443", "2379", "2380", "10250-10252"]
  }

  target_tags = ["k8s-role", "master"]
}

resource "google_compute_firewall" "k8s-worker-firewall" {
  name        = "${var.gcp_prefix}-worker-firewall"
  network      = google_compute_network.k8s-vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "10250", "30000-32767", "6783-6784"]
  }

  allow {
    protocol = "udp"
    ports    = ["6783-6784"]
  }

  target_tags = ["k8s-role", "node"]
}


resource "google_compute_subnetwork" "k8s-subnet" {
  name = "${var.gcp_prefix}-subnet"
  network = google_compute_network.k8s-vpc.name
  ip_cidr_range = "192.168.0.0/16"
}


resource "tls_private_key" "k8s-tls-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "google_compute_instance" "k8s-worker-nodes" {
  count = var.num_instances
  name         = "${var.gcp_prefix}-worker-${count.index + 1}"
  machine_type = var.machine_type
  zone = var.gcp_zone
  tags = ["k8s-role", "node"]
  boot_disk {
    device_name = "${var.gcp_prefix}-worker-disk-${count.index + 1}"
    auto_delete = "true"
    initialize_params {
      size = var.cloud_worker_volume_size
      image = var.gcp_disk_image
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.k8s-tls-private-key.public_key_openssh} ubuntu"
  }
  labels = {
    cluster-name = var.gcp_prefix
    application = "k8s"
    role = "node"
    cloud_provider = "gcp"
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.name
    access_config {}
  }
}

resource "google_compute_instance" "k8s-master-nodes" {
  count = 1
  name         = "${var.gcp_prefix}-master-${count.index + 1}"
  machine_type = "e2-standard-4"
  zone = var.gcp_zone
  tags = ["k8s-role", "master"]
  boot_disk {
    device_name = "${var.gcp_prefix}-master-disk-${count.index + 1}"
    auto_delete = "true"
    initialize_params {
      size = var.cloud_master_volume_size
      image = var.gcp_disk_image
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.k8s-tls-private-key.public_key_openssh} ubuntu"
  }
  labels = {
    cluster-name = var.gcp_prefix
    application = "k8s"
    role = "master"
    cloud_provider = "gcp"
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.name
    access_config {}
  }
}

resource "local_file" "k8s-local-private-key" {
    content          = tls_private_key.k8s-tls-private-key.private_key_pem
    filename         = "/tmp/${var.gcp_prefix}-key-private.pem"
    file_permission  = "0600"
}

resource "local_file" "k8s-local-public-key" {
    content          = tls_private_key.k8s-tls-private-key.public_key_openssh
    filename         = "/tmp/${var.gcp_prefix}-key.pub"
    file_permission  = "0600"
}
