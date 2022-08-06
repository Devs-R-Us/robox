install

lang en_US.UTF-8
keyboard us
timezone US/Pacific

text
skipx

firstboot --disabled
selinux --enforcing
firewall --enabled --service=ssh

network --device eth0 --bootproto dhcp --noipv6 --hostname=rocky8.localdomain

zerombr
clearpart --all --initlabel
bootloader --location=mbr --append="net.ifnames=0 biosdevname=0 no_timer_check"
autopart --nohome

rootpw locked
authconfig --enableshadow --passalgo=sha512

reboot --eject

# repo --name=BaseOS
url --url=http://f.p2x-3yz.us/OS/Rocky/8.6/

%packages --instLangs=en_US.utf8
@core
sudo
authconfig
-fprintd-pam
-intltool
-iwl*-firmware
-microcode_ctl
%end

%post

#echo "locked" | passwd --stdin

%end
