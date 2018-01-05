#!/bin/bash -x
uname -r
yum -y update
yum -y install epel-release
yum -y install python-setuptools
yum -y install git
yum -y install curl
yum -y install unzip
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
rm awscli-bundle.zip
easy_install https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz
cp /usr/lib/python2.7/site-packages/aws_cfn_bootstrap-1.4-py2.7.egg/init/redhat/cfn-hup /etc/init.d/cfn-hup
chmod +x /etc/init.d/cfn-hup
cd /opt
mkdir aws
cd aws
mkdir bin
ln -s /usr/bin/cfn-hup /opt/aws/bin/cfn-hup
systemctl is-enabled cfn-hup
systemctl enable cfn-hup
yum -y install perl-CPAN
yum -y install perl-libwww-perl
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
export PERL_MM_USE_DEFAULT=1
/usr/bin/perl -MCPAN -e 'install Bundle::LWP' ;
yum -y install perl-DateTime
yum -y install perl-Sys-Syslog
yum -y install unzip
echo '[sensu]
name=sensu
baseurl=https://sensu.global.ssl.fastly.net/yum/$releasever/$basearch/
gpgcheck=0
enabled=1' | sudo tee /etc/yum.repos.d/sensu.repo
yum -y install sensu
mkdir /etc/sensu/conf.d/
sudo mv ~/client.json /etc/sensu/conf.d/
sudo mv ~/api.json /etc/sensu/conf.d/
chkconfig sensu-client on
chkconfig sensu-server on
chkconfig sensu-api on
service sensu-client stop
service sensu-server stop
service sensu-api stop
cd /opt
curl -O http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip
unzip CloudWatchMonitoringScripts-1.2.1.zip
rm CloudWatchMonitoringScripts-1.2.1.zip
cd /etc/cloud
sed -i '/set_hostname/ c #### - set_hostname' cloud.cfg
sed -i '/update_hostname/ c #### - update_hostname' cloud.cfg
sed -i '/syslog_fix_perms: ~/ a preserve_hostname: true' cloud.cfg
curl -k 'https://puppet-mom.ap.org:8140/packages/current/install.bash' | sudo bash
/opt/puppetlabs/puppet/bin/puppet config set server nohost.ap.org --section main
/opt/puppetlabs/puppet/bin/gem install aws-sdk --no-ri --no-rdoc
/opt/puppetlabs/puppet/bin/gem install deep_merge --no-ri --no-rdoc
/opt/puppetlabs/puppet/bin/gem install r10k --no-ri --no-rdoc
/opt/puppetlabs/puppet/bin/gem install macaddr --no-ri --no-rdoc
cd /tmp
curl -k -O https://ctcaltsmps01.ap.org/Altiris/NS/NSCap/Bin/Unix/AgentInstall/Linux/x64/aex-bootstrap-linux
chmod u+x aex-bootstrap-linux && echo "y;"|./aex-bootstrap-linux https://CTCALTSMPS01.ap.org
/sbin/service rsyslog stop
/sbin/service auditd stop
/bin/package-cleanup --oldkernels --count=1
/usr/bin/yum clean all
/usr/sbin/logrotate -f /etc/logrotate.conf
/bin/rm -f /var/log/*-???????? /var/log/*.gz
/bin/rm -f /var/log/dmesg.old
/bin/rm -rf /var/log/anaconda
/bin/cat /dev/null > /var/log/audit/audit.log
/bin/cat /dev/null > /var/log/wtmp
/bin/cat /dev/null > /var/log/lastlog
/bin/cat /dev/null > /var/log/grubby
rm -f /etc/udev/rules.d/70*
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -f /etc/ssh/*key*
rm -f ~root/.bash_history
rm -f ~centos/.bash_history
unset HISTFILE
rm -rf ~root/.ssh/
rm -rf ~centos/.ssh/
rm -f ~root/anaconda-ks.cfg
rm -f ~centos/anaconda-ks.cfg
rm -f /home/centos/*.sh
/bin/rm -rf $(puppet config print ssldir)
#poweroff
