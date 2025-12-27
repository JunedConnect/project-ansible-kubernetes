3-Install-Kubernetes
====================

Installs and configures Kubernetes components (kubelet, kubeadm, kubectl) on target nodes. This role adds the official Kubernetes repository and installs specific versions of the required components.

Requirements
------------

- Ubuntu/Debian-based operating system
- Root or sudo access on target hosts
- Ansible 2.13.13
- Roles 1-prerequisites and 2-install-containerd must have been executed first
- Internet connectivity to download Kubernetes packages and signing keys

Role Variables
--------------

The following variables are defined in `defaults/main.yml` and can be overridden:

- `kube_version`: Kubernetes version to use (default: `v1.35`)
  - Used in repository URL: `https://pkgs.k8s.io/core:/stable:/{kube_version}/deb/`
- `kube_components_version`: Specific version of kubelet, kubeadm, kubectl (default: `1.35.0-1.1`)
  - Format: `<version>-<package_revision>`

Dependencies
------------

- Role 1-prerequisites must be executed first
- Role 2-install-containerd must be executed before this role

Example Playbook
----------------

    - name: install-kubernetes
      hosts: kubernetes_nodes
      become: true
      vars_files:
        - ./variables.yml
      roles:
        - { role: 3-install-kubernetes }

License
-------

Apache-2.0

Author Information
------------------

Juned
