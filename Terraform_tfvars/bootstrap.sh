

#!/bin/bash
host_name=$1 #$1=catalogue mentioned in main.tf file 56th line
environment=$2 #dont use env here, it is reserved in linux
app_version=$3 
yum install python3.11-devel python3.11-pip -y  #We can install ansible directly or through python.
pip3.11 install ansible botocore boto3 #botocore & boto3 are aws python packages. with this plugins or packages we can connect aws with any API.
ansible-pull -U https://github.com/hari-palepu/16_Jenkins_Roboshop_Ansible_Roles.git -e host_name=$host_name -e env=$environment -e app_version=$app_version main_tf.yaml  #Ansible repo
#ansible pull based maecahnism