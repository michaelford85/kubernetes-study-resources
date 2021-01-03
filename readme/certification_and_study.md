<p align="center">
  <img height="200" title="Kubernetes Logo" src="images/k8s_logo_with_border.png">
</p>

# Cloud Native Computing Foundation Certifications and Study Resources

Why should you bother with a Kubernetes certification? Where can you find resources to study for industry recognized Kubernetes exams? You'll find these answers here.


# Table Of Contents
[Why obtain a certification?](#why-obtain-a-certification)

[List of CNCF Certifications](#why-obtain-a-certification)

* [Certified Kubernetes Application Developer (CKAD)](#certified-kubernetes-application-developer-ckad)
* [Certified Kubernetes Administrator (CKA)](#certified-kubernetes-administrator-cka)
* [Certified Kubernetes Security Specialist (CKS)](#certified-kubernetes-security-specialist-cks)

[Certification Study Resources](#ckad-certification-study-resources)

* [KodeKloud](#kodekloud)
* [Kubernetes in Action by Marko Luksa](#kubernetes-in-action-by-marko-luksa)
* [Killer.sh Exam simulator](#killersh-exam-simulator)
<!-- - [Variables](#variables)
  * [default-vars.yml](#default-variables)
  * [linux_users.yml](#linux-users)
- [Credentials](#credentials)
  * [gmail_creds.yml](#gmail-credentials)
  * [redhat-activation-key.yml](#redhat-activation-key)
  * [snow_creds.yml](#servicenow-credentials)
  * [tower_creds.yml](#tower-credentials)
  * [vault_creds.yml](#hashicorp-vault-credentials) -->

## Why obtain a Certification?

In my personal journey to brand myself as a specialist in cloud-native technologies, I've found industry standard certifications to serve two purposes (that would apply to most people). First, certifications provide a way to gauge one's level of knowledge against a standardized benchmark. Passing the Certified Kubernetes Application Developer exam lets me know I've achieved a defined level of expertise. Secondly, having an industry standard certification promotes a level of credibility in the given topic with my customers and colleagues before I open my mouth. Both of these objectives can be achieved without the expense/time of a postgraduate University program, and with minimal cost - you might pay for a subscription to a self-paced learning resource, minimal cloud costs for access to necessary infrastructure, or a relatively small up front cost for a local lab (Raspberry Pi becomes very attractive here). Kubernetes is quickly becoming one of the most ubiquitous, standard methods of deploying/managing applications today, and having an industry standard certification in it will only help my career going forward.

## List of CNCF Certifications

### Certified Kubernetes Application Developer (CKAD)
The [Certified Kubernetes Application Developer](https://www.cncf.io/certification/ckad/) exam certifies that users can design, build, configure, and expose cloud native applications for Kubernetes. A Certified Kubernetes Application Developer can define application resources and use core primitives to build, monitor, and troubleshoot scalable applications and tools in Kubernetes.

### Certified Kubernetes Administrator (CKA)
The purpose of the [Certified Kubernetes Administrator](https://www.cncf.io/certification/cka/) program is to provide assurance that CKAs have the skills, knowledge, and competency to perform the responsibilities of Kubernetes administrators.

### Certified Kubernetes Security Specialist (CKS)
The [Certified Kubernetes Security Specialist](https://www.cncf.io/certification/cks/) program provides assurance that a CKS has the skills, knowledge, and competence on a broad range of best practices for securing container-based applications and Kubernetes platforms during build, deployment and runtime. CKA certification is required to sit for this exam.

## CKAD Certification Study Resources

These are the resources I recommend for preparing for the Certified Kubernetes Application Developer Exam:

### KodeKloud
Run by Mumshad Mannambeth, [KodeKloud](https://kodekloud.com/) is training website geared toward DevOps technologies. In addition to teaching general Kubernetes/Docker containers, there are courses specifically for the CKAD and CKA exams. The courses all have on-demand interactive labs that you can do, so that after learning about a particular concept, you can try it out for yourself. There is no additional cost for you to spin up these on-demand labs. At the end of the CKAD course, you can find lightning labs and mock exams, made to test your overall knowledge and readiness for the CKAD/CKA exam. At $35/month, I could not recommend this site more.

### Kubernetes in Action by Marko Luksa
In addition to KodeKloud, I recommend purchasing the book **Kubernetes in Action** by Marko Luksa, which can be found on the Manning Publications website. This book taught me not only the commands/k8s objects manageable in Kubernetes, but also more in depth explanations of how k8s works, genera design principles, etc. I find that my theoretical and conceptual understanding of kubernetes increased after reading about a topic, which then made me faster when doing labs/accomplishing tasks.

### Killer.sh Exam simulator
After you are comfortable having gone through the KodeKloud CKAD course and read the Kubernetes in Action book, I recommend buying an exam simulator from [killer.sh](https://killer.sh/). The CKAD exam simulator(which costs ~$37 USD) is spun up for up two two sessions, each for 36 hours. You are given 20 tasks, and can choose to time yourself for 2 hours as you would get for the actual CKAD exam. What you should keep in mind here is that the exam simulator is MUCH more difficult than the actual CKAD exam. If you can get a passing score on this simulator, you are more than ready for the CKAD. You can continue working the exercises for the entire 36 hours, which I suggest you do as the exercises are very involved and will test/reinforce your knowledge.
