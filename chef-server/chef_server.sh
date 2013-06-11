#!/bin/bash

#deb http://apt.opscode.com <release> main
#deb-src http://apt.opscode.com <release> main
#curl http://apt.opscode.com/packages@opscode.com.gpg.key | sudo apt-key add -

apt-get update
apt-get -y install make g++ gem

sudo mkdir /etc/chef/
cp /vagrant/services/chef_server/solo.rb /etc/chef/

chef-solo -c /etc/chef/solo.rb -j /vagrant/services/chef_server/chef.json -r http://s3.amazonaws.com/chef-solo/bootstrap-latest.tar.gz
gem install dep_selector --no-ri --no-rdoc
gem install yajl-ruby --no-ri --no-rdoc
gem uninstall haml
gem install haml --version '~>3.0' --no-ri --no-rdoc

netstat -l | grep 4000 #Chef Server
netstat -l | grep 5984 #CouchDB
netstat -l | grep 5672 #RabbitMQ
netstat -l | grep 8983 #Chef Solr
ps -ef | grep expander #Chef Expander

knife configure -i --defaults -r .
knife client list
export EDITOR='echo'
knife client create -a -e echo -n -f /vagrant/services/chef_server/creds/administrator.pem administrator
export EDITOR='vim'

/etc/init.d/chef-server-webui start
netstat -l | grep 4040 #Chef Server Web UI

ntpdate pool.ntp.org

mkdir -p ~/.chef
sudo cp /etc/chef/validation.pem /etc/chef/webui.pem ~/.chef
