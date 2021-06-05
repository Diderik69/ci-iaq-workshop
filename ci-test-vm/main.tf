# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}

# Create a new SSH key
resource "hcloud_ssh_key" "ansible-test-ssh-key" {
  name = "Ansible Test VM SSH Key"
  public_key = file(var.ssh_key)
}

# Create a server
resource "hcloud_server" "ansible-test-vm" {
  name = "ansible-test-instance"
  image = "ubuntu-20.04"
  server_type = "cx11"
  location = "nbg1"
  ssh_keys = [
    "Ansible Test VM SSH Key"
  ]

  provisioner "local-exec" {
    command = "sleep 20; ssh-keygen -R ${hcloud_server.ansible-test-vm.ipv4_address}; ssh-keyscan -t rsa -H ${hcloud_server.ansible-test-vm.ipv4_address} >> ~/.ssh/known_hosts"
  }
}

output "public_ip_address" {
  value = "${hcloud_server.ansible-test-vm.ipv4_address}"
}
