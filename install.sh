#! /bin/sh
uid=$(/usr/bin/id -u) && [ "$uid" = "0" ] || { echo "must be root"; exit 1; }
apt-get install figlet python
mkdir -p /etc/update-motd.d/
cp sh_scripts/* /etc/update-motd.d/
chmod a+x /etc/update-motd.d/*
hostname | figlet -c -w 68 > /etc/motd.tail
echo "session    optional   pam_motd.so  motd=/var/run/motd" >> /etc/pam.d/login
echo "session    optional   pam_motd.so  motd=/var/run/motd" >> /etc/pam.d/sshd
mv ./sysinfo /usr/lib/
