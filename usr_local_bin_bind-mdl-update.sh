#!/bin/sh
#
# Ansible managed
#
## download and install malware domains list as DNZ blackholed domains

export PATH=/bin:/usr/bin:/usr/sbin
umask 022

out=/var/named/chroot/etc/spywaredomains.zones.zip
cd /var/named/chroot/etc
wget -q -O $out http://malware-domains.com/files/spywaredomains.zones.zip
[ -f /var/named/chroot/etc/spywaredomains.zones ] &&  mv /var/named/chroot/etc/spywaredomains.zones /var/named/chroot/etc/spywaredomains.zones.0
[ -s $out ] && unzip -q $out \
	&& perl -pi -e 's@/etc/namedb@/var/named/chroot/etc@;' /var/named/chroot/etc/spywaredomains.zones \
	&& named-checkconf -t /var/named/chroot/etc/.. /etc/named.conf \
    || touch /var/named/chroot/etc/spywaredomains.zones