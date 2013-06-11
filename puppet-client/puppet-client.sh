#Copy ssh keys so our the client can register with the server itself.
mkdir /root/.ssh
cp /vagrant/vagrant_rsa /root/.ssh/
chmod 400 /root/.ssh/vagrant_rsa

#Test that the the puppet client can talk to the puppet server
apt-get -y install puppet

#Let the puppet server know that the client is trying to connect
puppetd --test

#Sign my cert
ssh -o StrictHostKeyChecking=no -i /root/.ssh/vagrant_rsa vagrant@puppet 'sudo puppetca --sign puppet-client'

#Connect to the puppet-server
puppetd --test
