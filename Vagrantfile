# -*- mode: ruby -*-
# vi: set ft=ruby :
#  _    __                             __  _____ __
# | |  / /___ _____ __________ _____  / /_/ __(_) /__
# | | / / __ `/ __ `/ ___/ __ `/ __ \/ __/ /_/ / / _ \
# | |/ / /_/ / /_/ / /  / /_/ / / / / /_/ __/ / /  __/
# |___/\__,_/\__, /_/   \__,_/_/ /_/\__/_/ /_/_/\___/
#           /____/

# This is the Vagrantfile that I use to create test enviornments prior to
# deployment on actual hardware. I use ruby hashes to define:
#
#   * Which box the Vagrant configuration will use, if the box isn't present
#     download it from the defined url.
#   * The host entries for the box
#   * The IP defined for the virtual network of the box
#   * The bridged interface that will be exposed to the network enabling access
#     to the node by others.
#   * Provisioning information that is run after a vagrant up

#Define each configuration in a ruby hash
servers = {"base"  => {"box"   => "base",
                       "box_url"   => "http://files.vagrantup.com/precise64.box"
                       },

           "base_host_only" => {"box"   => "base",
                                "box_url"   => "http://files.vagrantup.com/precise64.box",
                                "hostnames" => "host.only",
                                "ip"        => "123.123.123.2",
                                },

           "base_bridged"   => {"box"   => "base",
                                "box_url"   => "http://files.vagrantup.com/precise64.box",
                                "hostnames" => "bridged.only",
                                "ip"        => "123.123.123.3",
                                "bridged"   => "wifi"
                                },

           "services"    =>    {"box"   => "old",
                                "box_url"   => "http://files.vagrantup.com/lucid64.box",
                                "hostnames" => "services.cloud "\
                                               "chef.cloud "\
                                               "chef-server ",
                                "ip"        => "123.123.123.100",
                                "bridged"   => "wifi",
                                "shell_path" => "services/services.sh",
                                "memory"    => "4096"
                                },

           "chef-client"    =>    { "chef_server_url" => "http://services.cloud:4000",
                                    "hostnames"       => "chef-client",
                                    "ip"              => "123.123.123.101"
                                    },

           "puppet"    =>    {"box"   => "base",
                              "box_url"   => "http://files.vagrantup.com/precise64.box",
                              "hostnames" => "puppet-server "\
                                             "puppet.cloud "\
                                             "puppet ",
                                "ip"        => "123.123.123.102",
                                "bridged"   => "wifi",
                                "shell_path" => "puppet-server/puppet_server.sh",
                                },

           "puppet-client"    =>    {"box"   => "base",
                                     "box_url"   => "http://files.vagrantup.com/precise64.box",
                                     "hostnames" => "puppet-client.cloud "\
                                                    "puppet-client ",
                                     "ip"        => "123.123.123.103",
                                     "bridged"   => "wifi",
                                     "shell_path" => "puppet-client/puppet-client.sh",
                                     },

           "puppet-apply"      =>    {"box"       => "base",
                                      "box_url"   => "http://files.vagrantup.com/precise64.box",
                                      "hostnames" => "puppet-apply.cloud "\
                                                     "puppet-apply ",
                                      "ip"        => "123.123.123.104",
                                      "bridged"   => "wifi",
                                      "manifests_path" => "./puppet-server/manifests",
                                      "manifests_file" => "lamp.pp"
                                      }
}

# Here's a quick breakdown on what the single letter objects mean.
# b - box configuration
# c - imported configuration (value in hash above)
# s - server (key in hash above)
# v - vagrant

Vagrant::Config.run do |v|
#Vagrant.configure("2") do |v|

  # For each configuration from the hash above:
  servers.each do |s, c|

    #Define a vagrant instance and do box configuration
    v.vm.define s do |b|

      # Determine which box to use
      if c.has_key?("box")
          b.vm.box = c["box"]
          b.vm.box_url = c["box_url"]
      else
          b.vm.box = "base"
          b.vm.box_url = "http://files.vagrantup.com/precise64.box"
      end

      # Forward ports
      b.vm.forward_port 80, 8000

      # Vagrant 1.0 Network Config for Host Only Networking
      if c['ip']
        b.vm.network :hostonly, c["ip"], :netmask => "255.255.0.0"
      end

      # Determine the platform
      if RUBY_PLATFORM.include? 'linux'
        if c['bridged'] == 'wire'
          b.vm.network :bridged, :bridge => "eth0"
        elseif c['bridged'] == 'wifi'
          b.vm.network :bridged, :bridge => "eth1"
        end
      elseif RUBY_PLATFORM.include? 'darwin'
        if c['bridged'] == 'wire'
          b.vm.network :bridged, :bridge => "en0: Ethernet"
        elseif c['bridged'] == 'wifi'
          b.vm.network :bridged, :bridge => "en1: Wi-Fi (AirPort)"
        end
      end

      #Customize memory on the box, default to 1gb
      if c['memory']
        b.vm.customize ["modifyvm", :id, "--memory", c['memory']]
      else
        b.vm.customize ["modifyvm", :id, "--memory", 1024]
      end

      # Configure provider specific information
      #b.vm.provider :virtualbox do |vb|
      #    vb.customize ["modifyvm", :id, 
      #                  "--cpuexecutioncap", "40", 
      #                  "--cpus", "1",
      #                  "--memory", "1200"]

          #Add a host only adapter if it is specified
          #if c['ip']
          #    vb.network_adapter 2, :hostonly, c["ip"]
          #end
          #Add a bridged adapter if it is specified
          #if c['bridged'] 
          #    vb.network_adapter 3, :bridged => "en0: Wi-Fi (AirPort)"
          #end
      #end

      # My first 5 minutes on a server:
      # http://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers
      #
      #b.vm.provision :shell, :inline => "apt-get y update; apt-get y upgrade"
      #b.vm.provision :shell, :inline => "apt-get install -y fail2ban"
      #b.vm.provision :shell, :inline => "useradd deploy"
      #b.vm.provision :shell, :inline => "mkdir /home/deploy"
      #b.vm.provision :shell, :inline => "mkdir /home/deploy/.ssh"
      #b.vm.provision :shell, :inline => "chmod 700 /home/deploy/.ssh"
      #Use the vagrant key to the to access deploy user, (NEVER IN PRODUCTION)
      #b.vm.provision :shell, :inline => "cp ~vagrant/authorized_keys /home/deploy/.ssh"
      # Setup the firewall
      #b.vm.provision :shell, :inline => "ufw allow from 123.123.123.1 to any port 22"
      #b.vm.allow     :shell, :inline => "ufw allow 80"
      #b.vm.allow     :shell, :inline => "ufw allow 443"
      #b.vm.allow     :shell, :inline => "ufw enable"
      #b.vm.provision :shell, :inline => "apt-get install unattended-upgrades"
      #b.vm.provision :shell, :inline => "apt-get -y install logwatch"
      #b.vm.provision :shell, :inline => "echo '/usr/sbin/logwatch --output mail --mailto test@gmail.com --detail high' >> /etc/cron.daily/00logwatch"

      # Install The Editor
      b.vm.provision :shell, :inline => "apt-get -y install vim"

      # Install SCMs
      #b.vm.provision :shell, :inline => "apt-get -y install git subversion mercurial meld"

      # Install Tools
      b.vm.provision :shell, :inline => "apt-get -y install wget curl"

      # Set the machine hostname based on the server name
      b.vm.provision :shell, :inline => "hostname " + s
      b.vm.provision :shell, :inline => "sed -i 's/localhost/" + s + "/g' /etc/hosts"

      # Modify /etc/hosts on all machines in the current Vagrant configuration
      # should know about all the other possible machines they should be
      # dealing with
      b.vm.provision :shell, :inline => "echo >> /etc/hosts"
      servers.each do |s, c|
          if s != 'base'
              hoststring = "echo '" + c["ip"] + " " + s + " " + c['hostnames'] + "' >> /etc/hosts"
              b.vm.provision :shell, :inline => hoststring
          end
      end

      # I like my setup the way I like it, you should too.
      # b.vm.provision :shell, :path => "setup.sh"

      # Provision with puppet_server
      if c.has_key?("puppet_server") and
          c.has_key?("puppet_node_name")
          b.vm.provision :puppet_server do |ps|
              ps.puppet_server = c["puppet_server"]
              ps.puppet_node = c[s]
              ps.options = c["puppet_options"]
          end
      end

      # Provision with puppet-apply
      if c.has_key?("manifests_path") #and
          c.has_key?("manifest_file")
          b.vm.provision :puppet do |pa|
              pa.options = "--verbose --debug"
              pa.manifests_path = c["manifests_path"]
              pa.manifest_file = c["manifests_file"]
          end
      end

      # Provision with chef_server
      if c.has_key?("chef_server_url") and
          c.has_key?("validation_key_path")
          b.vm.provision :chef_client do |cs|
              cs.chef_server_url = "http://services:4000"
              cs.validation_key_path = "services/chef_server/creds/admin.pem"
          end
      end

      # Provision with chef solo
        if c.has_key?("cookbooks_path") or
           c.has_key?("runlist")
             b.vm.provision :chef_solo do |solo|
               solo.cookbooks_path = "chef"
             end
        end

      #Provision with shell
      if c.has_key?("shell_path")
          b.vm.provision :shell, :path => c["shell_path"]
      end
    end
  end
end
