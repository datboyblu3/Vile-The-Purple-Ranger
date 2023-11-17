#!/bin/bash

imageURL=https://cloud-images.ubuntu.com/lunar/current/lunar-server-cloudimg-amd64.img
imageName="lunar-server-cloudimg-amd64.img"
volumeName="groot"
virtualMachineId="9000"
templateName="lunar-tpl"
tmp_cores="2"
tmp_memory="2048"

rm *.img
wget -O $imageName $imageURL
qm destroy $virtualMachineId
virt-customize -a $imageName --install qemu-guest-agent
qm create $virtualMachineId --name $templateName --memory $tmp_memory --cores $tmp_cores --net0 virtio,bridge=vmbr0
qm importdisk $virtualMachineId $imageName $volumeName
qm set $virtualMachineId --scsihw virtio-scsi-pci --scsi0 $volumeName:vm-$virtualMachineId-disk-0
qm set $virtualMachineId --boot c --bootdisk scsi0
qm set $virtualMachineId --ide2 $volumeName:cloudinit
qm set $virtualMachineId --serial0 socket --vga serial0
qm template $virtualMachineId
