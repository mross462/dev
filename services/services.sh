####################
#Install Chef Server
####################
#/vagrant/services/chef_server/chef_server.sh

######################
#Install Puppet Server
######################
/vagrant/services/puppet_server/puppet_server.sh


#################
#Install and Configure HAProxy
##################

#Install the haproxy in the repo to run it as a service
#apt-get -y install haproxy make libpcre3-dev libssl-dev

#Build and install the latest version
#cd $HOME/repos
#git clone https://github.com/mross462/haproxy.git
#cd haproxy
#make clean
#apt-get -y install libpcre3-dev libssl-dev
#make TARGET=linux2628 USE_STATIC_PCRE=1 USE_OPENSSL=1;
#make PREFIX=/usr install

#Copy the configuration over
#cp /vagrant/server/haproxy.cfg /etc/haproxy/haproxy.cfg
#cp /vagrant/server/haproxy.pem /etc/haproxy/haproxy.pem

#Enable HAProxy to Be Run As a Daemon
#sed -i 's/ENABLED=0/ENABLED=1/' /etc/default/haproxy
#service haproxy restart

##################
#Install and Configure Ganglia
##################

#Configure Gagnlia Monitoring for the services node
#apt-get -y install ganglia-webfrontend
#cp /vagrant/common_config/ganglia/gmond.conf /etc/ganglia/gmond.conf
#mkdir /etc/ganglia/conf.d/
#mkdir /usr/lib/ganglia/python_modules
#service ganglia-monitor
#service ganglia-monitor restart

#Configure Ganglia Front End
#/vagrant/services/ganglia-web/ganglia-web.sh

###############################
#Install and Configure Graylog2
###############################

#Install the graylog2-server
#apt-get -y install openjdk-6-jre make maven
#echo 'JAVA_HOME=/usr/lib/jvm/java-1.6.0-openjdk-amd64' >> /etc/environment
#cd $HOME/repos
#git clone git@github.com:Graylog2/graylog2-server
#cd graylog2-server
#git checkout origin/develop
#make clean; make prepare; make; make install;

#Install the graylog2-web interface
#apt-get -y install ruby1.8 rubygems rake make libopenssl-ruby ruby-dev build-essential git-core
#gem install bundler
#cd $HOME/repos
#git clone git@github.com:Graylog2/graylog2-web-interface
#cd graylog2-web-interface
#bundle install



