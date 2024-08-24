provider "local" {}

resource "null_resource" "generate_ssh_key" {
  provisioner "local-exec" {
    command = <<EOT
    if [ ! -f ${pathexpand(var.private_key_path)} ]; then
      ssh-keygen -t rsa -b 2048 -f ${pathexpand(var.private_key_path)} -q -N "";
    fi
    EOT
  }
}

resource "null_resource" "install_docker" {
  provisioner "local-exec" {
    command = <<EOT
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh ./get-docker.sh --dry-run
    EOT
  }
}

resource "null_resource" "install_kind" {
  provisioner "local-exec" {
    command = <<EOT
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" &&
    chmod +x ./kubectl &&
    sudo mv ./kubectl /usr/local/bin/kubectl &&
    curl -Lo ./kind "https://kind.sigs.k8s.io/dl/$(curl -s https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | grep -oP '(?<=tag_name": ")[^"]+')/kind-linux-amd64" &&
    chmod +x ./kind &&
    sudo mv ./kind /usr/local/bin/kind &&
    kind create cluster
    EOT
  }

  depends_on = [null_resource.install_docker]
}

module "docker" {
  source = "./modules/docker"
}

module "kubernetes" {
  source = "./modules/kubernetes"
}