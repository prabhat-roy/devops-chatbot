resource "google_compute_firewall" "internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc.name

  allow {
    protocol = "all"
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = [22]
  }
  source_ranges = concat(
    [local.my_ip],
    local.gcp_browser_ips
  )
  direction = "INGRESS"
}

resource "google_compute_firewall" "chatbot" {
  name    = "chatbot-access"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = [8000]
  }
  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
}

resource "google_compute_firewall" "chatbot" {
  name    = "chatbot-access"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = [80]
  }
  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
}

