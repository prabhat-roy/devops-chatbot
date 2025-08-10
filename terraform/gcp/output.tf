output "chatbot" {
  value       = "http://${google_compute_address.chatbot.address}:80"
  description = "URL for the chatbot service"
}