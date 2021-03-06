<p align="center">
  <img height="200" title="Kubernetes Logo" src="images/k8s_logo_with_border.png">
</p>

Kubernetes CKAD exam tips and useful learning links list.

## Useful Tips/Commands for the CKAD Exam

### General exam tips:
- **Read through the FAQs for the CNCF Kubernetes Certification Exams:** Make sure to read through everything in these [publicly available FAQs](https://docs.linuxfoundation.org/tc-docs/certification/faq-cka-ckad-cks) so that you know about the environment, what resources you have access to, how the exam is proctored, etc.
- **Know how to navigate the kubernetes.io documentation:** When taking the CKAD exam, you are allowed a single additional tab, in which you can navigate to https://kubernetes.io/docs/ and all its subdomains. If you try to search for a topic, this will actually put you at https://kubernetes.io/docs/search/, which is against the rules. I suggest knowing how to navigate to things without searching. Most of what you'll need can be found under the *Concepts* and *Tasks* section of the documentation home.
- When you start the exam, I recommend inputting the linux command, `$ alias k=kubectl`, which allows you to type `k` rather than `kubectl`. Not having to type in `kubectl` all the time both shaves seconds off of your exam time, makes the experience less tedious.
- Specifying the namespace at the *beginning* of a kubectl command (rather than at the end, which is what I did when first learning) makes it easier to manipulate a command later on as changes usually are made at the end of a CLI command. For example:
  - `$ kubectl -n <namespace> run busyboxpod --image=busybox`
    - Getting pod status becomes a lot easier here if after pressing the up key, you simply have to delete  the run portion and type `$kubectl -n <namespace> get pods`.



### Useful kubectl commands:
- [kubectl Commands Cheat Sheet (Swiss Army DevOps)](https://swissarmydevops.com/containers/kubernetes/kubernetes-cheat-sheet)
- [kubectl Commands Cheat Sheet (A Cloud Guru/Linux Academy)](https://linuxacademy.com/site-content/uploads/2019/04/Kubernetes-Cheat-Sheet_07182019.pdf)
- `$ kubectl explain <k8s object> --recursive | less` - This lists ALL of the manifest options for the given k8s object in a vim output; you can then search throughout in order to confirm/learn specific options.
- `$ kubectl create <k8s object> --dry-run=client -o yaml > manifest.yml` - This command is useful when you wish to create a kubernetes manifest with options that cannot be added on the command line, and you want to avoid creating a manifest file from scratch (which you should never have to do). The YAML manifest will output to the specified file, which you can then edit with your favorite editor and then invoke via the `$ kubectl create -f manifest.yml` command.
- `$ kubectl run tmp --rm --image=busybox -i -- wget -O- <host>:<port>`: Creates a temporary pod in the specified namespace that can `wget` a host. Helpful when you want to determine if a service/pod is accessible.
-  `$ kubectl run tmp --image=curlimages/curl --rm -i  -- <host>:<port>`: Creates a temporary pod in the specified namespace that can `curl` a host. Helpful when you want to determine if a service/pod is accessible.
- `$ kubectl -n <namespace> get ep`: get endpoints of all services in the specified namspace. This is a quick way to ensure that your service is selecting your intended pods.
- `$ kubectl annotate <k8s object> -l key=value app:"this is the way"`: Quickly annotate several pods, a deployment, etc. You can use the selector (`-l`) argument to quickly annotate several pods at once.
- Creating a DaemonSet imperatively:
  As a DaemonSet cannot be created imperatively directly, you can start by using an imperative command to create a deployment:
  - `$ kubectl create deployment nginxds --image=nginx --dry-run=client -o yaml > daemonset.yml`
  - From there, remove the `replicas: 1`, `strategy: {}` and `status: {}` lines from the file, and replace `Deployment` with `Daemonset`.
  - You can now deploy the DaemonSet with the command `$ kubectl create -f daemonset.yml`


## General links
- [The difference between Megabytes and Mibibytes](https://www.gbmb.org/blog/what-is-the-difference-between-megabytes-and-mebibytes-32)
- [Kubernetes Metrics Server](https://github.com/kubernetes-sigs/metrics-server)

## Kubernetes networking

- [Kubernetes Networking Reference Links](https://github.com/michaelford85/kubernetes-networking-links) (forked from [Nicolas Leiva](https://github.com/nleiva/kubernetes-networking-links) with my additions)

<!--
- [Linux Networking Explained](https://events.static.linuxfound.org/sites/events/files/slides/2016%20-%20Linux%20Networking%20explained_0.pdf) by [tgraf](https://github.com/tgraf)
- [An In-Depth Guide to iptables, the Linux Firewall](https://www.booleanworld.com/depth-guide-iptables-linux-firewall/) by [supriyo-biswas](https://github.com/supriyo-biswas)
- Monitoring and Tuning the Linux Networking Stack:
  - [Receiving Data](https://blog.packagecloud.io/eng/2016/06/22/monitoring-tuning-linux-networking-stack-receiving-data/)
  - [Sending Data](https://blog.packagecloud.io/eng/2017/02/06/monitoring-tuning-linux-networking-stack-sending-data/)

### Linux Namespaces
- [Introducing Linux Network Namespaces](https://blog.scottlowe.org/2013/09/04/introducing-linux-network-namespaces/) by [scottslowe](https://github.com/scottslowe)
- [Making sense Of Linux namespaces](https://prefetch.net/blog/2018/02/22/making-sense-of-linux-namespaces/) by [Matty9191](https://github.com/Matty9191)
- [A deep dive into Linux namespaces](http://ifeanyi.co/posts/linux-namespaces-part-1/) by [iffyio](https://github.com/iffyio)
- [Namespaces in operation](https://lwn.net/Articles/531114/) by [mkerrisk](https://github.com/mkerrisk)
- [Containers from Scratch](https://speakerdeck.com/ericchiang/coreos-fest-2017-containers-from-scratch), [recording](https://www.youtube.com/watch?v=wyqoi52k5jM) by [ericchiang](https://github.com/ericchiang)
- Containers from scratch: The sequel, [recording](https://www.youtube.com/watch?v=_TsSmSu57Zo) by [lizrice](https://github.com/lizrice)
- [Linux Namespaces](https://medium.com/@teddyking/linux-namespaces-850489d3ccf) by [teddyking](https://github.com/teddyking)
- [Namespaces, Threads, and Go](https://github.com/containernetworking/plugins/tree/master/pkg/ns) by [squeed](https://github.com/squeed)
  - [Linux Namespaces and Go Don't Mix](https://www.weave.works/blog/linux-namespaces-and-go-don-t-mix) by [brb](https://github.com/brb)

## Kubernetes Networking
- [The Almighty Pause Container](https://www.ianlewis.org/en/almighty-pause-container) by [ianlewis](https://github.com/ianlewis)
- There is No Such Thing as Container Networking, [recording](https://www.youtube.com/watch?v=t98CX8Tberc) by [kelseyhightower](https://github.com/kelseyhightower)
- [Kubernetes Networking: Behind the scenes](https://medium.com/@nleiva/kubernetes-networking-behind-the-scenes-39a1ab1792bb) by [nleiva](https://github.com/nleiva)
- [Kubernetes Networking Demystified: A Brief Guide](https://www.cncf.io/blog/2020/01/30/kubernetes-networking-demystified-a-brief-guide/)
- [Understanding kubernetes networking: pods](https://medium.com/google-cloud/understanding-kubernetes-networking-pods-7117dd28727) by [Markbnj](https://github.com/Markbnj)
- [An illustrated guide to Kubernetes Networking [Part 1]](https://medium.com/@ApsOps/an-illustrated-guide-to-kubernetes-networking-part-1-d1ede3322727) by [ApsOps](https://github.com/ApsOps)
- [A Hacker’s Guide to Kubernetes Networking](https://thenewstack.io/hackers-guide-kubernetes-networking/) by [yaronha](https://github.com/yaronha)
- [Kubernetes Cluster Networking](https://kubernetes.io/docs/concepts/cluster-administration/networking/)
- [Why Kubernetes doesn’t use libnetwork](https://kubernetes.io/blog/2016/01/why-kubernetes-doesnt-use-libnetwork/) by [thockin](https://github.com/thockin)
- [Understanding kubernetes networking: services](https://medium.com/google-cloud/understanding-kubernetes-networking-services-f0cb48e4cc82) by [Markbnj](https://github.com/Markbnj)
- [Kubernetes Networking](https://cloudnativelabs.github.io/post/2017-04-18-kubernetes-networking/) by [cloudnativelabs](https://github.com/cloudnativelabs)
- [Understand and Troubleshoot the “Magic” of k8s Networking](https://kccnceu18.sched.com/event/Dquy/blackholes-and-wormholes-understand-and-troubleshoot-the-magic-of-kubernetes-networking-minhan-xia-rohit-ramkumar-google-intermediate-skill-level-slides-attached), [recording](https://www.youtube.com/watch?v=knIJEzTd3kc) by [rramkumar1](https://github.com/rramkumar1) and [freehan](https://github.com/freehan)
- [An Illustrated Guide to Kubernetes Networking](https://speakerd.s3.amazonaws.com/presentations/005d36f0113d4773be8866496142485e/Illustrated_guid_to_kubernetes_networking.pdf) by [thockin](https://github.com/thockin)
- [The ins and outs of networking in Google Container Engine and Kubernetes](https://speakerdeck.com/thockin/the-ins-and-outs-of-networking-in-google-container-engine), [recording](https://www.youtube.com/watch?v=y2bhV81MfKQ) by [thockin](https://github.com/thockin) and [matchstick](https://github.com/matchstick)
- Introduction to Kubernetes Networking, [recording](https://www.youtube.com/watch?v=7OFw3lgSb1Q) by [bboreham](https://github.com/bboreham)
- [Life of a Packet](https://github.com/sbueringer/kubecon-slides/blob/master/slides/2017-kubecon-eu/Life%20of%20a%20Packet%20%5BI%5D%20-%20Michael%20Rubin%2C%20Google%20-%20KubeCon%20EU%20'17-%20Life%20of%20a%20Packet.pdf), [recording](https://www.youtube.com/watch?v=0Omvgd7Hg1I) by [matchstick](https://github.com/matchstick)
- [Google Kubernetes Engine networking](https://cloud.google.com/kubernetes-engine/docs/concepts/network-overview)
- [Operating a Kubernetes network](https://jvns.ca/blog/2017/10/10/operating-a-kubernetes-network/) by [jvns](https://github.com/jvns)
- [Understanding the Kubernetes Networking Model](https://sookocheff.com/post/kubernetes/understanding-kubernetes-networking-model/) by [soofaloofa](https://github.com/soofaloofa)
- [Kubernetes Networking Master Class](https://rancher.com/events/2018/kubernetes-networking-masterclass-june-online-meetup/)
- [Kubernetes and Networks - why is this so dang hard?](https://speakerdeck.com/thockin/kubernetes-and-networks-why-is-this-so-dang-hard) by [thockin](https://github.com/thockin)
- [Bringing Traffic Into Your Kubernetes Cluster](https://speakerdeck.com/thockin/bringing-traffic-into-your-kubernetes-cluster) by [thockin](https://github.com/thockin)
- [Deconstructing Kubernetes Networking](https://eevans.co/blog/deconstructing-kubernetes-networking/)

### IPVS
- [IPVS-Based In-Cluster Load Balancing Deep Dive](https://kubernetes.io/blog/2018/07/09/ipvs-based-in-cluster-load-balancing-deep-dive/)

### eBPF
- [eBPF, Microservices, Docker, and Cilium: From Novice to Seasoned](http://www.adelzaalouk.me/2017/security-bpf-docker-cillium/) by [zanetworker](https://github.com/zanetworker)
- [Why is the kernel community replacing iptables with BPF?](https://cilium.io/blog/2018/04/17/why-is-the-kernel-community-replacing-iptables/) by [cilium](https://github.com/cilium)
- [Using eBPF in Kubernetes](https://kubernetes.io/blog/2017/12/using-ebpf-in-kubernetes/)
- [BPF and XDP Reference Guide](https://cilium.readthedocs.io/en/v1.1/bpf/) by [cilium](https://github.com/cilium)

### IPv6
- [IPv4/IPv6 dual-stack](https://kubernetes.io/docs/concepts/services-networking/dual-stack/)
- [Dual-stack Kubernetes with kubeadm-dind-cluster](http://blog.michali.net/2018/11/08/dual-stack-kubernetes-with-kubeadm-dind-cluster/) by [pmichali](https://github.com/pmichali)
- [kube-v6](https://github.com/leblancd/kube-v6) by [leblancd](https://github.com/leblancd)
- [Kubernetes in IPv6 only](https://opsnotice.xyz/kubernetes-ipv6-only/) by [valentin2105](https://github.com/valentin2105)
- [Add IPv4/IPv6 dual stack KEP](https://github.com/kubernetes/enhancements/pull/648)

### Multi-cluster
- [Kubernetes multi-cluster networking made simple](https://medium.com/@nleiva/kubernetes-multi-cluster-networking-made-simple-c8f26827813) by [nleiva](https://github.com/nleiva)

## CNI
- [Container Network Interface Specification](https://github.com/containernetworking/cni/blob/master/SPEC.md)
- [Container Network Interface and Go](https://www.youtube.com/watch?v=0SXPsLvB0UI)
- [Understanding CNI (Container Networking Interface)](https://www.dasblinkenlichten.com/understanding-cni-container-networking-interface/)
- CNI, the Container Network Interface, [recording](https://skillsmatter.com/skillscasts/10811-cni-the-container-network-interface) by [bboreham](https://github.com/bboreham)
- The Container Network Interface (CNI), [recording](https://www.youtube.com/watch?v=_-9kItVUUCw) by [eyakubovich](https://github.com/eyakubovich)
- KubeCon "Container Network Interface: Network Plugins", [recording](https://www.youtube.com/watch?v=-DB1nxrUwbA) by [eyakubovich](https://github.com/eyakubovich)
- [Kubernetes and the CNI Where We Are and What's Next](https://github.com/sbueringer/kubecon-slides/blob/master/slides/2018-kubecon-eu/Kubernetes%20and%20the%20CNI%20Where%20We%20Are%20and%20What's%20Next%20-%20Casey%20Callendrello%2C%20CoreOS%20(Intermediate%20Skill%20Level)%20-%20Kubernetes-and-the-CNI-Kubecon-218.pdf), [recording](https://www.youtube.com/watch?v=Vn6KYkNevBQ) by [squeed](https://github.com/squeed)
- [Comparative Kubernetes networks solutions](https://www.objectif-libre.com/en/blog/2018/07/05/k8s-network-solutions-comparison/)
- [Comparison of Networking Solutions for Kubernetes](http://machinezone.github.io/research/networking-solutions-for-kubernetes/)
- [Comparative Kubernetes networks solutions](https://www.objectif-libre.com/en/blog/2018/07/05/k8s-network-solutions-comparison/)
- [Benchmark results of Kubernetes network plugins (CNI) over 10Gbit/s network](https://itnext.io/benchmark-results-of-kubernetes-network-plugins-cni-over-10gbit-s-network-36475925a560)
- [Large-scale network simulations in Kubernetes, Part 1 - Building a CNI plugin](https://networkop.co.uk/post/2018-11-k8s-topo-p1/)
- [Large-scale network simulations in Kubernetes, Part 2 - Network topology](https://networkop.co.uk/post/2018-11-k8s-topo-p2/)
- [How to Write Your Own CNI Plug-in with Bash](https://www.altoros.com/blog/kubernetes-networking-writing-your-own-simple-cni-plug-in-with-bash/)

## Network Solutions Details

### Calico
- [Calico for Kubernetes networking: the basics & examples](https://medium.com/flant-com/calico-for-kubernetes-networking-792b41e19d69)


## DNS
- [An Introduction to the Kubernetes DNS Service](https://www.digitalocean.com/community/tutorials/an-introduction-to-the-kubernetes-dns-service)
- [5 – 15s DNS lookups on Kubernetes?](https://blog.quentin-machu.fr/2018/06/24/5-15s-dns-lookups-on-kubernetes/) by [Quentin-M](https://github.com/Quentin-M)
- [Debugging and Monitoring DNS issues in Kubernetes](https://cilium.io/blog/2019/12/18/how-to-debug-dns-issues-in-k8s/)

## Routing
- [Kubernetes Traffic Engineering with BGP](https://www.asykim.com/blog/kubernetes-traffic-engineering-with-bgp) by [andrewsykim](https://github.com/andrewsykim)

## Service Mesh

- The Service Mesh: Past, Present, and Future, [recording](https://www.youtube.com/watch?v=2trOvMUuLkk) by [wmorgan](https://github.com/wmorgan)
- [Using Istio Multicluster to "Burst" Workloads Between Clusters](https://codelabs.developers.google.com/codelabs/istio-multi-burst/#0) -->
