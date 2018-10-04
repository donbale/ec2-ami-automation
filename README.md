# ec2-ami-automation
Two scripts to add to your crontab. 
1. ec2-create-image.sh: Creates a full amazon machine image from a currently running instance. 
2. del-snapshots.sh: Deregisters all amazon images that are older than a date D and then deletes all snapshots that are older than D (Amazon charges you for storage of snapshots, so you want to clean these up. There is no charge for having AMI's but they must be deregistered before deleting their associated snapshots)

## Notes
- If you are not using an ubuntu os you may need to change your use of date to: __PASTDUE=$(date -v -3d "+%Y-%m-%d").

- Change '3d' to whatever length of time you want. If you can afford to keep snapshots associated with 10 Amazon machine images, then change to __PASTDUE=$(date -v -10d "+%Y-%m-%d") or __PASTDUE=$(date --date="4 days ago" +"%Y-%m-%d"), for ubuntu
