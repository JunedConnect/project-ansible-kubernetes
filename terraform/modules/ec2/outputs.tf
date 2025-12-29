output "bastion_host_public_ip" {
  description = "Public IP of the bastion host instance"
  value       = aws_instance.bastion_host.public_ip
}

output "control_plane_private_ip" {
  description = "Private IP of the control plane instance"
  value       = aws_instance.control_plane.private_ip
}

output "worker_node_1_private_ip" {
  description = "Private IP of worker node 1 instance"
  value       = aws_instance.worker_node_1.private_ip
}

output "worker_node_2_private_ip" {
  description = "Private IP of worker node 2 instance"
  value       = aws_instance.worker_node_2.private_ip
}
