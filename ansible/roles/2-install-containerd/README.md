2-Install-Containerd
====================

Installs and configures containerd as the container runtime for Kubernetes. This role ensures containerd is properly configured with systemd cgroup driver support, which is required for optimal Kubernetes cluster performance.

Requirements
------------

- Ubuntu/Debian-based operating system
- Root or sudo access on target hosts
- Ansible 2.13.13
- Role 1-prerequisites must have been executed first

Role Variables
--------------

This role requires no user-defined variables. All configuration is automated.

Dependencies
------------

- Role 1-prerequisites must be executed first

Example Playbook
----------------

    - name: install-containerd
      hosts: kubernetes_nodes
      become: true
      roles:
        - { role: 2-install-containerd }

License
-------

Apache-2.0

Author Information
------------------

Juned
