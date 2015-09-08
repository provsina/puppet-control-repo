ntpdate pool.ntp.org
apt-get update
apt-get -y install ntp
service ntp restart
if [ ! -f puppetlabs-release-pc1-trusty.deb ]; then
  wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
fi
dpkg -i puppetlabs-release-pc1-trusty.deb
apt-get update
apt-get install puppet-agent
