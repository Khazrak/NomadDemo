# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
# Update apt and get dependencies
sudo apt-get update
sudo apt-get install -y unzip curl wget vim

# Download Nomad
echo Fetching Nomad...
cd /tmp/
curl -sSL https://releases.hashicorp.com/nomad/0.5.2/nomad_0.5.2_linux_amd64.zip -o nomad.zip
curl -sSL https://releases.hashicorp.com/consul/0.7.2/consul_0.7.2_linux_amd64.zip -o consul.zip
echo Installing Nomad...
unzip nomad.zip
sudo chmod +x nomad
sudo mv nomad /usr/bin/nomad

sudo mkdir -p /etc/nomad.d
sudo chmod a+w /etc/nomad.d

curl -sSL https://releases.hashicorp.com/consul/0.7.2/consul_0.7.2_linux_amd64.zip -o consul.zip
echo Installing Consul...
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul

sudo mkdir -p /etc/consul.d
sudo chmod a+w /etc/consul.d

SCRIPT

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
FILES_DIR = File.join(File.dirname(__FILE__), "files")


$num_instances = 3
$instance_name_prefix = "nomad-demo"

$share_home = false
$vm_gui = false
$vm_memory = 1024
$vm_cpus = 1
$vm_starting_ip = "172.17.8.100"

$vm_ip = $vm_starting_ip

Vagrant.configure(2) do |config|
  config.vm.box = "puphpet/ubuntu1404-x64"
 # config.vm.box = "ubuntu/xenial64"
  config.ssh.insert_key = true
  
  config.vm.provision "shell", inline: $script, privileged: false
  config.vm.provision "docker" # Just install it

   if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :box
   end

   (1..$num_instances).each do |i|
    
        config.vm.define vm_name = "%s-%02d" % [$instance_name_prefix, i] do |config|
            config.vm.hostname = vm_name
            config.vm.provision "file", :source => "#{FILES_DIR}", :destination => "/home/vagrant"
         
            ip = IPAddr.new($vm_ip)
            $vm_ip = ip.succ.to_s
            config.vm.network :private_network, ip: $vm_ip

            config.vm.provision "shell", privileged: false, inline: "sudo sed -i -e \"s/IP/#{$vm_ip}/\" /home/vagrant/files/server*" 

            config.vm.provision "shell", privileged: false, inline: "sudo sed -i -e \"s/IP/#{$vm_ip}/\" /home/vagrant/files/client*" 

            config.vm.provision "shell", privileged: false, inline: "sudo sed -i -e \"s/IP/#{$vm_ip}/\" /home/vagrant/files/start_consul.sh" 

            config.vm.provision "shell", privileged: false, inline: "sudo sed -i -e \"s/IP/#{$vm_ip}/\" /home/v    agrant/files/consul_join.sh"

            config.vm.provision "shell" do |s|
				ip = $vm_ip
				s.inline = "sudo sed -i -e \"s/.*nomad.*/$1 $2/\" /etc/hosts"
				s.args = ["#{ip}","#{vm_name}"]
			end
        end
  end
  
  config.vm.provider :virtualbox do |vb|
      vb.gui = $vm_gui
      vb.memory = $vm_memory
      vb.cpus = $vm_cpus
  end

  # Increase memory for Parallels Desktop
  config.vm.provider "parallels" do |p, o|
      p.memory = $vm_memory
  end

  config.vm.provider :virtualbox do |vb|
        vb.gui = $vm_gui
        vb.memory = $vm_memory
        vb.cpus = $vm_cpus
  end

  # Increase memory for VMware
  ["vmware_fusion", "vmware_workstation"].each do |p|
    config.vm.provider p do |v|
      v.vmx["memsize"] = "1024"
    end
  end
end
