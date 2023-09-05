#!/usr/bin/env bash

max_background_jobs=25
while read -r f; do
  # execute command here
  echo ${f} >> outputing.txt
  aws dynamodb batch-write-item --profile sso-veego-dev --region us-west-2 --request-items file://${f} &
  while [[ $(jobs -r | wc -l | tr -d " ") -ge ${max_background_jobs} ]]; do
    sleep 1
  done
done < <(ls *.json)