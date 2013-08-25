#! /bin/sh

# Is this root ? If not, bye bye.
uid=$(/usr/bin/id -u) && [ "$uid" = "0" ] || { echo "must be root"; exit 1; }

apt-get uninstall figlet
apt-get purge figlet

rm /etc/update-motd.d/00tail
rm /etc/update-motd.d/10sysinfo
rm /etc/motd.tail

rm -fr /usr/lib/sysinfo

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