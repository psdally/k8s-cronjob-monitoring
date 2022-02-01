#!/bin/bash
CRONJOBNAME=$1

# Get the status of the last job invoked by the cronjob - specifically:
# Use kubectl to retrieve the jobs in the namespace.  Then, with jq
# from the .items[] array, select only those jobs that are owned by the 
# cronjob of interest. Sort those items by their startTime, so that we 
# can retrieve the last one. Retuurn the .status.failed field from that job
STATUS=$(kubectl get job -o=json | jq '[.items[] | select(.metadata.ownerReferences[0].name==env.CRONJOBNAME)] | sort_by(.status.startTime) | .[-1] | .status.failed')
if [ "$STATUS" == "1" ]; then
   echo "Cronjob $CRONJOBNAME failed"
   exit -1
else
  echo "Cronjob $CRONJOBNAME succeeded"
  exit 0
fi