1-Prerequisites
===============

Prepares target nodes for Kubernetes installation by configuring system-level prerequisites. This is the first role that should be executed in the Kubernetes deployment workflow.

Requirements
------------

- Ubuntu/Debian-based operating system
- Root or sudo access on target hosts
- Ansible 2.13.13

Role Variables
--------------

This role uses built-in Ansible variables:

- `inventory_hostname`: Automatically provided by Ansible; used to set the hostname of each node

No user-defined variables are required for this role.

Dependencies
------------

None - this is the first role in the deployment sequence.

Example Playbook
----------------

    - name: prerequisites
      hosts: kubernetes_nodes
      become: true
      roles:
        - { role: 1-prerequisites }

License
-------

Apache-2.0

Author Information
------------------

Juned
