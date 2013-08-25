#! /bin/sh

# Is this root ? If not, bye bye.
uid=$(/usr/bin/id -u) && [ "$uid" = "0" ] || { echo "must be root"; exit 1; }

# installs figlet to output hostname to ascii, python, and 
# lsb-release to have detailed informations about the OS
apt-get uninstall figlet
apt-get purge figlet

# copy the bash scripts which display infos
rm /etc/update-motd.d/00tail
rm /etc/update-motd.d/10sysinfo
rm /etc/motd.tail

# move the python files that process the informations to be displayed
rm -fr /usr/lib/sysinfo

# deletes the content of /etc/motd
rm /etc/motd
mv /etc/motd.old /etc/motd

# setup for Debian 7
if [ -f /var/run/motd.dynamic.old ]
then
	mv /var/run/motd.dynamic.old /var/run/motd.dynamic
	sed -i 's/session    optional   pam_motd.so  motd=\/var\/run\/motd/#session    optional   pam_motd.so  motd=\/var\/run\/motd/g' /etc/pam.d/login
	sed -i 's/session    optional   pam_motd.so  motd=\/var\/run\/motd/#session    optional   pam_motd.so  motd=\/var\/run\/motd/g' /etc/pam.d/sshd
fi
if [ -f /etc/init.d/motd ]
then
	sed -i 's/#uname -sn/uname -sn/g' /etc/init.d/motd
fi