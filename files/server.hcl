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

   # retry_join = ["172.17.8.101:4648"]
}
