bind_addr = "IP"
# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/tmp/server"

consul {
  address = "IP:8500"
}


# Enable the server
server {
    enabled = true

    # Self-elect, should be 3 or 5 for production
    bootstrap_expect = 3
}
