# <img src="https://raw.githubusercontent.com/JunedConnect/project-ansible-kubernetes/main/images/ansible-logo.jpg" alt="Ansible Logo" width="40" height="40"> Ansible Auto

The project demonstrates a **Kubernetes cluster deployment on AWS EC2** using **Terraform** to provision AWS infrastructure and **Ansible** to install and configure Kubernetes. This setup showcases how to build a Kubernetes cluster using `kubeadm` on EC2 instances, with a cluster nodes on private nodes and bastion host for secure access to cluster nodes.

**Everything is declarative and repeatable**, from infrastructure provisioning to cluster configuration.

<br>

## Key Features

- **Terraform** - Infrastructure provisioning for AWS VPC and EC2 instances
- **Ansible** - Automated Kubernetes cluster installation and configuration
- **kubeadm** - Kubernetes cluster initialisation
- **Cilium** - CNI for pod networking
- **Bastion Host** - Secure SSH access to private cluster nodes
- **Dynamic Inventory** - AWS EC2 inventory plugin for automatic host discovery

<br>

## Directory Structure

```
./
├── terraform/
│   ├── modules/                  # Terraform modules
│   │   ├── vpc/
│   │   └── ec2/
│   └── [terraform files]         # Root Terraform (.tf) files
├── ansible/
│   ├── ansible.cfg               # Ansible configuration
│   ├── inventory/
│   │   ├── aws_ec2.yml           # Dynamic EC2 inventory
│   │   └── group_vars/           # Group variables (currently not being used)
│   ├── playbooks/
│   │   └── install-kubernetes.yml # Main playbook
│   ├── roles/                    # Ansible roles
│   └── install-kubernetes-variables.yml             # Variables utilised for playbook
└── archive/                      # Archived files (old)
```

<br>

## Prerequisites

- Terraform
- Ansible
- AWS CLI configured with credentials
- kubectl
- SSH keypair (`~/.ssh/playground` and `~/.ssh/playground.pub`)

**Creating SSH Keypair**:

To create the SSH Keypair, run this command:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/playground
```

This creates both the private key (`~/.ssh/playground`) and public key (`~/.ssh/playground.pub`).

<br>

## Configuration Dependencies

Before deploying, update these configuration values:

**Terraform Configuration** (`terraform/terraform.tfvars`):
- `aws_tags` - Resource tags (Environment, Project, Owner, Terraform)

**Ansible Configuration** (`ansible/install-kubernetes-variables.yml`):
- `kube_version` - Kubernetes version
- `kube_components_version` - Kubernetes components version
- `cilium_version` - Cilium CNI version
- `clusterPoolIPv4PodCIDRList` - Cilium pod CIDR range

**Important**: Ensure that the Cilium pod CIDR range (configured in `ansible/install-kubernetes-variables.yml`) is different from the AWS VPC CIDR range (configured in `terraform/terraform.tfvars`). If they overlap, there will be a network clash and both Cilium and AWS networking will fail. For example, if your VPC uses `10.0.0.0/16`, use a different range like `20.0.0.0/8` for Cilium.

<br>

## How to Deploy

1. **Deploy Infrastructure**:

   ```bash
   cd terraform && terraform init && terraform apply
   ```
   This creates the VPC and EC2 instances (i.e. bastion host, control plane, and worker nodes) in AWS. The terraform output will display the IP addresses of the created instances.

2. **Verify Ansible Connectivity**:

   **Note**: Ansible uses the AWS credentials configured for your system (via AWS CLI or environment variables). If AWS credentials are not configured, Ansible will not be able to discover EC2 instances.

   Check that Ansible can discover the EC2 instances:

   ```bash
   cd ansible
   ansible-inventory -i inventory --graph
   ```
   This displays the discovered hosts grouped by their tags (e.g., `tag_control_plane`, `tag_worker_node`).

   Verify connectivity to all instances:

   ```bash
   cd ansible
   ansible all -m ping -i inventory
   ```
   This tests SSH connectivity to all EC2 instances via the bastion host.

3. **Install Kubernetes**:

   ```bash
   cd ansible
   ansible-playbook install-kubernetes.yml -i inventory
   ```
   This installs and configures Kubernetes on the EC2 instances.

<br>

## Accessing the Cluster

**SSH into Kubernetes Cluster Nodes**:

   To SSH into any cluster node (control plane or worker), use the bastion host as a jump host:

   ```bash
   ssh -o ProxyCommand="ssh -o StrictHostKeyChecking=no -i ~/.ssh/playground -W %h:%p -q ubuntu@<bastion-host-public-ip>" -i ~/.ssh/playground ubuntu@<kubernetes-cluster-private-ip>
   ```

   Replace:
   - `<bastion-host-public-ip>` with the bastion host's public IP (from `terraform output bastion_host_public_ip`)
   - `<kubernetes-cluster-private-ip>` with the private IP of the control plane or worker node (from `terraform outputs`)

**Using kubectl**:

   To use `kubectl` with the cluster, SSH into the control plane node (as shown with the command above). The Kubernetes context has already been configured, so you can use `kubectl` commands straight away:

   ```bash
   kubectl get nodes
   ```

   You can test the cluster by running a test pod:

   ```bash
   kubectl run nginx-test --image=nginx
   kubectl describe pod nginx-test
   ```

   The `kubectl describe` command will show which node the pod is running on.

<br>

## Cleanup

   To remove all infrastructure:

   ```bash
   cd terraform && terraform destroy
   ```

<br>

## Notes

- Some security group rules are intentionally permissive (e.g. SSH, Kubernetes API, and ICMP from `0.0.0.0/0`) for lab purposes. For production, restrict these CIDRs appropriately.
- The Ansible dynamic inventory automatically discovers EC2 instances based on tags, making it easy to extend the cluster without manual inventory management.
- The `group_vars` directory is currently not being used but can be configured to use variables if you wish.

<br>

## Resource Link

**Ansible Inventory**

https://docs.ansible.com/projects/ansible/latest/inventory_guide/intro_inventory.html
https://docs.ansible.com/projects/ansible/latest/collections/amazon/aws/docsite/aws_ec2_guide.html
https://docs.ansible.com/projects/ansible/latest/collections/amazon/aws/aws_ec2_inventory.html

**ContainerD**

https://kubernetes.io/docs/setup/production-environment/container-runtimes/


**Cilium Install**

https://docs.cilium.io/en/latest/gettingstarted/k8s-install-default/
https://docs.cilium.io/en/stable/helm-reference/#helm-reference


**Kubernetes and Cilium Networking Ports**

https://kubernetes.io/docs/reference/networking/ports-and-protocols/
https://docs.cilium.io/en/stable/operations/system_requirements/

**KubeADM**

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/

**KubeConfig - Creating Additional Users**
https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-certs/#kubeconfig-additional-users