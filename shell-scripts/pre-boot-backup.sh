#!/bin/bash

printf "\nprint IP address: \n"
/usr/sbin/ip r l

printf "\nprint route: \n"
/usr/sbin/route n

printf "\nprint connected ethernet devices: \n"
/usr/sbin/ip addr

printf "\nprint connected disks: \n"
/usr/sbin/fdisk -l

printf "\nprint mounted fs: \n"
/bin/df -h

printf "\nprint fstab file: \n"
cat /etc/fstab

printf "\nprint physical volumes: \n"
/usr/sbin/pvs

printf "\nprint volume groups: \n"
/usr/sbin/vgs

printf "\nprint logical volumes: \n"
/usr/sbin/lvs

printf "\nprint kernel: \n"
/bin/rpm -qa | grep kernel

printf "\ntake backup of /etc/hosts file: \n"
/bin/cat /etc/hosts
