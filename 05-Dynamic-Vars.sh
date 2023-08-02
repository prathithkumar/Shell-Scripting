#!/bin/bash

DATE="$(date +%F)"
SESSIONS_COUNT=$(who | wc -l)

echo  "Todays DATE is $DATE"
echo "Total Number of Active Sessions $SESSIONS_COUNT"