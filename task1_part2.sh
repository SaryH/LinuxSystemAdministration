#!/bin/bash

#Part 2: users, groups and permissions
#1- Add user: user1, set uid=601 Password: redhat. The user's login shell should be
#non-interactive. (no ssh access to server)
#2- Add user1 to group TrainingGroup.
#3- Add users: user2, user3. The Additional group of the two users: user2, user3 is the admin
#group Password: redhat, user 3 with root permissions

useradd -u 601 -s /sbin/nologin user1
passwd user1 << EOF
redhat
redhat
EOF

usermod -a -G TrainingGroup user1

useradd user2
useradd user3

passwd user2 << EOF
redhat
redhat
EOF

passwd user3 << EOF
redhat
redhat
EOF

usermod -a -G admin user2
usermod -a -G admin user3

echo "user3 ALL=(ALL) ALL" >> /etc/sudoers