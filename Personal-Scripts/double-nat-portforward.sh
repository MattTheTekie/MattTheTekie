#!/bin/bash
export LC_ALL=C
echo "SSH Reverse Tunnel UPNP port forwarder! - Made by MattTheTekie."
echo "I wish there was a shortner name for this."
echo "NOTICE: You may not be able to access the forwarded port externally on the same network it is forwarded on."
echo "NOTICE: This script is meant for ORBI systems with https://www.voxel-firmware.com/ CFW, and SSH access anabled."
echo "I am not liable if this script messes anything up with you're devices. BE WARNED!"
echo "Enter the locally desired port: "
read desired_port
echo "Enter the ssh hostname: "
read sshhost
echo "Enter the remote server port number(HTTP 80,FTP 21,etc...): "
read remote_port
echo "Enter the ssh user: "
read user
echo "Enter the desired external UPNP port: "
read modem_port
command="ssh -L $desired_port:$sshhost:$remote_port -N -o GatewayPorts=yes $user@$sshhost"
gnome-terminal -- bash -c "$command; exec bash"
ip=$(upnpc -l | grep "Local LAN ip address" | cut -d: -f2)
upnpc -a $ip $desired_port $modem_port TCP
echo "NOTICE: Now SSH into the ORBI system, install upnpc, then forward to the modem, and enjoy."
echo "NOTICE: You may not be able to access the forwarded port externally on the same network it is forwarded on."
