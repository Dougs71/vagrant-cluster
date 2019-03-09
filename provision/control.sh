echo Provisioning control...

sudo yum install -y ansible
sudo cp /vagrant/ansible/ansible.cfg /etc/ansible
sudo cp /vagrant/ansible/hosts /etc/ansible/hosts
