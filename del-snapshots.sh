#!/bin/bash

# Date is 4 days ago, but will delete/deregister anything 5 days or older
__PASTDUE=$(date --date="4 days ago" +"%Y-%m-%d")

images_to_deregister=($(aws ec2 describe-images --owners 403057575040 --query 'Images[?CreationDate<`'"$__PASTDUE"'`].{ID:ImageId}'))
echo "List of images to deregister as of $__PASTDUE: $images_to_deregister"

# Deregister images
for image in $images_to_deregister; do
  echo $image
  aws ec2 deregister-image --image-id $image
done

snapshots_to_delete=($(aws ec2 describe-snapshots --owner-ids 403057575040 --query 'Snapshots[?StartTime<`'"$__PASTDUE"'`].SnapshotId'))
echo "List of snapshots to delete after $__PASTDUE: $snapshots_to_delete"

# Delete snaphsots
for snap in $snapshots_to_delete; do
  echo $snap
  aws ec2 delete-snapshot --snapshot-id $snap
done
