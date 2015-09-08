ntpdate pool.ntp.org
apt-get update
sudo apt-get -y install ntp
service ntp restart
if [ ! -f puppetlabs-release-pc1-trusty.deb ]; then
    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
fi
dpkg -i puppetlabs-release-pc1-trusty.deb
apt-get update
apt-get install puppetserver -y
sudo sed -i 's/2g/512m/g' /etc/default/puppetserver
service puppetserver start
/opt/puppetlabs/puppet/bin/gem install r10k
apt-get install git -y
echo ***starting r10k***
if [ ! grep -R main /etc/puppetlabs/puppet/puppet.conf ]; then
  echo "[main]" >> /etc/puppetlabs/puppet/puppet.conf
  echo "dns_alt_names = `hostname`.us-west-2.compute.internal" >> /etc/puppetlabs/puppet/puppet.conf
  echo "[agent]" >> /etc/puppetlabs/puppet/puppet.conf
  echo "server = `hostname`.us-west-2.compute.internal" >> /etc/puppetlabs/puppet/puppet.conf
fi
#mkdir /etc/puppetlabs/r10k
#mkdir /etc/puppetlabs/r10k/cache
#
## The location to use for storing cached Git repos
#:cachedir: '/opt/puppetlabs/r10k/cache'
#
## A list of git repositories to create
#:sources:
#  # This will clone the git repository and instantiate an environment per
#  # branch in /etc/puppetlabs/code/environments
#    :my-org:
#      remote: 'git@github.com:provsina/puppet-control-repo.git'
#      basedir: '/etc/puppetlabs/code/environments'

sudo /opt/puppetlabs/puppet/bin/r10k deploy environment -p
