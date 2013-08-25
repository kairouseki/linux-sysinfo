#! /bin/sh

# Is this root ? If not, bye bye.
uid=$(/usr/bin/id -u) && [ "$uid" = "0" ] || { echo "must be root"; exit 1; }

# installs figlet to output hostname to ascii, python, and 
# lsb-release to have detailed informations about the OS
apt-get install figlet python lsb-release

# copy the bash scripts which display infos
mkdir -p /etc/update-motd.d/
cp sh_scripts/* /etc/update-motd.d/
chmod a+x /etc/update-motd.d/*

# move the python files that process the informations to be displayed
mv ./sysinfo /usr/lib/

# creates the ASCII output of the hostname
hostname | figlet -c -w 68 > /etc/motd.tail

# deletes the content of /etc/motd
mv /etc/motd /etc/motd.old
touch /etc/motd

# setup for Debian 7
if [ -f /var/run/motd.dynamic ]
then
	rm /var/run/motd.dynamic
	touch /var/run/motd.dynamic
	echo "session    optional   pam_motd.so  motd=/var/run/motd" >> /etc/pam.d/login
	echo "session    optional   pam_motd.so  motd=/var/run/motd" >> /etc/pam.d/sshd
fi
if [ -f /etc/init.d/motd ]
then
	
fi