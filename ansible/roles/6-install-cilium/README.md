6-Install-Cilium
================

Installs and configures Cilium as the Container Network Interface (CNI) plugin for the Kubernetes cluster. Cilium provides networking, security policies, and service mesh capabilities using eBPF technology. Tasks include: downloading Cilium CLI, verifying checksums, checking installation status, and installing with pod CIDR configuration.

Requirements
------------

- Ubuntu/Debian-based operating system
- Root or sudo access on target hosts
- Ansible 2.13.13
- Kubernetes cluster must be initialised (role 4 executed on control plane)
- All nodes must be part of the cluster (role 5 executed on workers)
- Internet connectivity to download Cilium releases and dependencies

Role Variables
--------------

The following variables are defined in `defaults/main.yml` and can be overridden:

- `cilium_version`: Cilium version to install (default: `v1.18.3`)
  - Must be a valid release version available on GitHub
- `clusterPoolIPv4PodCIDRList`: IPv4 CIDR range for pod networking (default: `20.0.0.0/8`)
  - Should not overlap with your host network
  - Used in Cilium IP address management (IPAM) configuration

Dependencies
------------

- Role 4-initialise-kubeadm must be executed on control plane first
- Role 5-join-workers-to-cluster must be executed on all worker nodes

Example Playbook
----------------

    - name: install-cilium
      hosts: control_plane
      become: true
      vars_files:
        - ./variables.yml
      roles:
        - { role: 6-install-cilium }

License
-------

Apache-2.0

Author Information
------------------

Juned
