#!/bin/bash

while getopts h:e:p:v flag
do
    case "${flag}" in
        h) host=${OPTARG};;
        e) email=${OPTARG};;
        p) password=${OPTARG};;
        v) phpv=${OPTARG};;
    esac
done

echo "Host: $host"
echo "Email: $email"
echo "Password: $password"

# update the centos
yum update -y

# install epel release and yum utils
yum install -y epel-release yum-utils

# disable all php versions
yum-config-manager --disable remi-php*

# enable php 7.4
yum-config-manager --enable remi-php$phpv


# install vesta cp yes to all

curl -O http://vestacp.com/pub/vst-install.sh

bash vst-install.sh --nginx yes --phpfpm yes --apache no --named yes --remi yes --vsftpd yes --proftpd no --iptables yes --fail2ban no --quota no --exim yes --dovecot yes --spamassassin no --clamav no --softaculous no --mysql yes --postgresql no --hostname $host --email $email --password $password

echo "VestaCP installed"

# install nodejs 16
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
yum install -y nodejs

echo "NodeJS installed"

# install composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

echo "Composer Version: $(composer --version)"

# install git
yum install -y git

echo "Git installed"

# install nano
yum install -y nano

echo "Nano installed"

# install unzip
yum install -y unzip

echo "Unzip installed"

# changed default editor to nano
echo "set nowrap" >>/etc/nanorc

#set profile.d
echo "export EDITOR=nano" >>/etc/profile.d/nano.sh
echo "export VISUAL=nano" >>/etc/profile.d/nano.sh

#set bash_profile
echo "export EDITOR=nano" >>~/.bash_profile
echo "export VISUAL=nano" >>~/.bash_profile

#add FILEMANAGER_KEY='ILOVEREO' if not exists
if ! grep -q "FILEMANAGER_KEY='ILOVEREO'" /usr/local/vesta/conf/vesta.conf; then
    echo "FILEMANAGER_KEY='ILOVEREO'" >>/usr/local/vesta/conf/vesta.conf
fi

#add to crontab
crontab -l | { cat; echo "0 */1 * * * /usr/bin/sed -i \"/FILEMANAGER_KEY=''/d\" /usr/local/vesta/conf/vesta.conf >> /usr/local/vesta/conf/vesta.conf && sudo /usr/bin/grep -q -F \"FILEMANAGER_KEY='ILOVEREO'\" /usr/local/vesta/conf/vesta.conf || /usr/bin/echo \"FILEMANAGER_KEY='ILOVEREO'\" >> /usr/local/vesta/conf/vesta.conf"; } | crontab -

