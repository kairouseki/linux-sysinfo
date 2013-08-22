#! /bin/sh
if [[ $UID -ne 0 ]]; then
    echo "$0 must be run as root"
    exit 1
fi
apt-get install figlet python
mkdir -p /etc/update-motd.d/
cp sh_scripts/* /etc/update-motd.d/
chmod a+x /etc/update-motd.d/*
hostname | figlet -c -w 68 > /etc/motd.tail
echo "session    optional   pam_motd.so  motd=/var/run/motd" >> /etc/pam.d/login
echo "session    optional   pam_motd.so  motd=/var/run/motd" >> /etc/pam.d/sshd
mv ./sysinfo /usr/lib/
