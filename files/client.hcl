# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/tmp/client"

consul {
  address = "IP:8500"
}


# Enable the client
client {
    enabled = true

    # For demo assume we are talking to server1. For production,
    # this should be like "nomad.service.consul:4647" and a system
    # like Consul used for service discovery.
    #servers = ["172.17.8.101:4647"]
}

# Modify our port to avoid a collision with server
ports {
    http = 5656
}
