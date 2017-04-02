#!/bin/bash -x
yum -y install epel-release
yum -y install python-setuptools
yum -y update
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
rm awscli-bundle.zip
yum -y install perl-CPAN
yum -y install perl-libwww-perl
yum -y install perl-DateTime
yum -y install perl-Sys-Syslog
yum -y install unzip
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -f /etc/ssh/*key*
rm -f ~root/.bash_history
rm -f ~centos/.bash_history
unset HISTFILE
#poweroff
