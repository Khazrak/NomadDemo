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

echo Installing Nomad...
unzip nomad.zip
sudo chmod +x nomad
sudo mv nomad /usr/bin/nomad

sudo mkdir -p /etc/nomad.d
sudo chmod a+w /etc/nomad.d




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
  config.ssh.insert_key = true
  
  config.vm.provision "shell", inline: $script, privileged: false
  config.vm.provision "docker" # Just install it

   if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :box
   end

   (1..$num_instances).each do |i|
    
        config.vm.define vm_name = "%s-%02d" % [$instance_name_prefix, i] do |config|
            config.vm.hostname = vm_name
            config.vm.provision "file", :source => "#{FILES_DIR}", :destination => "/home/vagrant/files"
            
            # Set hostname's IP to made advertisement Just Work
            config.vm.provision "shell", privileged: true, inline: "sudo sed -i -e \"s/.*nomad.*/$(ip route get 1 | awk '{print $NF;exit}') #{vm_name}/\" /etc/hosts"
            
            config.vm.provision "shell", privileged: true, inline: <<-SHELL
                echo \"export test=mytest\" >> /etc/profile.d/myvars.sh
	    SHELL
            
            ip = IPAddr.new($vm_ip)
            $vm_ip = ip.succ.to_s
            config.vm.network :private_network, ip: $vm_ip
            config.vm.provision "shell", privileged: false, inline: "sudo sed -i -e \"s/IP/\\\"#{$vm_ip}\\\"/\" /home/vagrant/files/server*" 
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
