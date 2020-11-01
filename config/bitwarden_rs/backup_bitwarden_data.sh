#!/bin/bash

date=$(date '+%Y-%m-%d %H:%M')

cd /opt/bitwarden/bw-data
git add -A
git commit -m "backup at $date"
git push
