#!/bin/bash

#Task1 Part1:Create a volume group, and set 16M as extends. And divided a volume group containing 50 extends on volume group lv, make it as ext4 file system, and mounted automatically under /mnt/data. Please note that this should be implemented on the second disk

#creating partition
sudo fdisk /dev/sdh << EOF
n
p
1


t
8e
w
EOF

#creating physcial volume
sudo pvcreate /dev/sdh1
#creating volume group
sudo vgcreate -s 16M volumeGroup /dev/sdh1
#creating logical volume
sudo lvcreate -l 50 volumeGroup -n logicalVolume

#formatting it
sudo mkfs -t ext4 /dev/volumeGroup/logicalVolume

#mounting
sudo mkdir /mnt/data
sudo mount /dev/volumeGroup/logicalVolume /mnt/data

#automatic mounting setup
sudo echo "/dev/volumeGroup/logicalVolume /mnt/data ext4 defaults 0 0" >> /etc/fstab