echo Provisioning control...

sudo yum install -y ansible
sudo yum install -y python-pip
sudo pip install --upgrade pip boto botocore boto3 awscli

sudo cp /vagrant/ansible/ansible.cfg /etc/ansible
sudo cp /vagrant/ansible/hosts /etc/ansible/hosts
