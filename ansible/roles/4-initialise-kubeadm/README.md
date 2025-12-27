4-Initialise-Kubeadm
====================

Initialises the Kubernetes control plane using kubeadm. This role sets up the control plane node and generates the worker node join command for cluster formation. This role should only be executed on the control plane node.

Requirements
------------

- Ubuntu/Debian-based operating system
- Root or sudo access on target hosts
- Ansible 2.13.13
- Roles 1-prerequisites, 2-install-containerd, and 3-install-kubernetes must have been executed
- Must be executed on the control plane node only

Role Variables
--------------

The following variables are used (defined in `defaults/main.yml`):

- `ansible_user`: User account for kubeconfig setup (default: `ubuntu`)

Generated Variables (used by role 5-join-workers-to-cluster):

- `worker_node_join_command`: The kubeadm join command for worker nodes
  - Stored as a delegated fact on localhost

Dependencies
------------

- Role 1-prerequisites must be executed first
- Role 2-install-containerd must be executed second
- Role 3-install-kubernetes must be executed third
- Role 5-join-workers-to-cluster depends on this role

Example Playbook
----------------

    - name: initialise-kubeadm
      hosts: control_plane
      become: true
      roles:
        - { role: 4-initialise-kubeadm }

License
-------

Apache-2.0

Author Information
------------------

Juned
