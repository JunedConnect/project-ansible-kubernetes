#!/bin/bash
set -e

echo "Step 1: Disable swap and set hostname"
sudo swapoff -a
sudo hostnamectl set-hostname worker-node-2
sleep 2

echo "Step 2: System update and upgrade"
sudo apt-get update
sudo apt-get upgrade -y
sleep 2

echo "Step 3: Enable IP forwarding"
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

echo "Step 4: Install and configure containerd"
sudo apt-get -y install containerd
sleep 2

sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
sudo systemctl restart containerd
sleep 2

echo "Step 5: Install Kubernetes components"
# sudo mkdir -p -m 755 /etc/apt/keyrings
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.35/deb/Release.key | \
sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.35/deb/ /' | \
sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet=1.35.0-1.1 kubeadm=1.35.0-1.1 kubectl=1.35.0-1.1
sudo apt-mark hold kubelet kubeadm kubectl
sleep 2