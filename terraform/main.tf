provider "local" {}

# resource "null_resource" "generate_ssh_key" {
#   provisioner "local-exec" {
#     command = <<EOT
#     if [ ! -f ${pathexpand(var.private_key_path)} ]; then
#       ssh-keygen -t rsa -b 2048 -f ${pathexpand(var.private_key_path)} -q -N "";
#     fi
#     EOT
#   }
# }

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx
  name  = "nginx-test"
  ports {
    internal = 80
    external = 8000
  }
}

resource "kind_cluster" "default" {
    name            = "cluster"
    node_image      = "kindest/node:v1.27.1"
    kubeconfig_path = pathexpand("/tmp/config")
    wait_for_ready  = true

    kind_config {
      kind        = "Cluster"
      api_version = "kind.x-k8s.io/v1alpha4"

      node {
          role = "control-plane"
          extra_port_mappings {
              container_port = 80
              host_port      = 80
          }
      }

      node {
          role = "worker"
      }
  }
}
