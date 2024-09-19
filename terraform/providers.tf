terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.23.1"
    }
    kind = {
      source = "tehcyx/kind"
      version = "0.4.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "kind" {}