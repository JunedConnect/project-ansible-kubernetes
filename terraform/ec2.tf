resource "aws_instance" "control_plane" {

  ami           = "ami-0a0ff88d0f3f85a14" # Ubuntu 22.04 LTS
  instance_type = "t3.medium"
  subnet_id     = module.vpc.public_subnet_1_id # make sure to move to private subnet in the end
  security_groups = [aws_security_group.kubernetes.id]
  key_name = aws_key_pair.this.key_name
  tags = {
    name = "control-plane"
    role = "control-plane"
    project = "ansible-kubernetes"
  }
}

resource "aws_instance" "worker_node_1" {

  ami           = "ami-0a0ff88d0f3f85a14" # Ubuntu 22.04 LTS
  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnet_1_id # make sure to move to private subnet in the end
  security_groups = [aws_security_group.kubernetes.id]
  key_name = aws_key_pair.this.key_name
  tags = {
    name = "worker-node-1"
    role = "worker-node"
    project = "ansible-kubernetes"
  }
}

resource "aws_instance" "worker_node_2" {

  ami           = "ami-0a0ff88d0f3f85a14" # Ubuntu 22.04 LTS
  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnet_2_id # make sure to move to private subnet in the end
  security_groups = [aws_security_group.kubernetes.id]
  key_name = aws_key_pair.this.key_name
  tags = {
    name = "worker-node-2"
    role = "worker-node"
    project = "ansible-kubernetes"
  }
}

resource "aws_security_group" "kubernetes" {
  name        = "kubernetes"
  description = "kubernetes security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = "playground-key"
  public_key = file("~/.ssh/playground.pub")
}