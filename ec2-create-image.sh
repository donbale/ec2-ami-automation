#!/usr/bin/env bash

#
# @Purpose 		Creates an image (AMI) of the given EC2 instance
# @Background 	Meant to be run as a cronjob. Requires that awscli is installed. Assumes that the 
# instance running this command has the permission ec2:CreateImage assigned via IAM.
#
# @Usage: 		ec2-create-image <instance-id>
#

DATE=$(date +%m-%d-%Y) 
AMI_NAME="EMR-WEB-BACKUP_${DATE}"
AMI_DESCRIPTION="Backup of our open emr web server - $DATE"
INSTANCE_ID=i-04aa0b72205235e99

printf "Requesting AMI for instance $INSTANCE_ID...\n"
printf "New ami: $AMI_NAME; From instance id: $INSTANCE_ID...\n"

aws ec2 create-image --instance-id $INSTANCE_ID --name "$AMI_NAME" --description "$AMI_DESCRIPTION" --no-reboot

if [ $? -eq 0 ]; then
	printf "AMI request complete!\n"
fi
