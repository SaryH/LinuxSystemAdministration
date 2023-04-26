#!/bin/bash
#Part 3: SSH
#Generate SSH key and connect to different VM without password.

remote_host="remoteVM.sary.com"
remote_user="Sary"
ssh_dir="$HOME/.ssh"
ssh_key="id_rsa"

ssh-keygen -t rsa -f "$ssh_dir/$ssh_key"
ssh-copy-id -i "$ssh_dir/$ssh_key.pub" "$remote_user@$remote_host"
ssh "$remote_user@$remote_host"
