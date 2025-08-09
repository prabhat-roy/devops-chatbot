resource "google_compute_instance" "chatbot" {
  name         = "chatbot-vm"
  machine_type = var.machine_type
  zone         = local.default_zone
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = var.disk_size
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.public[local.default_zone].id

    access_config {
      nat_ip = google_compute_address.chatbot.address
    }
  }

  metadata = {
    ssh-keys = "${var.admin_user}:${file(var.public_key)}"
  }

}

resource "google_compute_address" "chatbot" {
  name    = "chatbot-public-ip"
  project = var.project_id
  region  = var.gcp_region
}
/*
resource "null_resource" "chatbot_provision" {
  depends_on = [google_compute_instance.chatbot]

  connection {
    type        = "ssh"
    host        = google_compute_address.chatbot.address
    user        = var.admin_user
    private_key = file(var.private_key)
  }


  provisioner "file" {
    source      = "../../install_update.sh"
    destination = "/tmp"
  }

  # ✅ Run orchestrator script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_update.sh",
      "sudo bash /tmp/install_update.sh"
    ]
  }
}
*/