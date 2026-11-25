#!/bin/bash

# Linux Authentication Monitor - Version 2
# Read-only security monitoring exercise

WINDOW="5 minutes"

# Read the journal before filtering so a failed read cannot be mistaken for zero events.
if ! JOURNAL=$(journalctl --since "$WINDOW ago" \
  --no-pager -o short-iso); then
    echo "=================================="
    echo " LINUX AUTHENTICATION MONITOR"
    echo "=================================="
    echo "Failures Detected: UNKNOWN"
    echo "Status: ERROR"
    echo "EVENT EVIDENCE"
    echo "Unavailable: journalctl failed."
    echo "=================================="
    exit 1
fi

EVENTS=$(printf '%s\n' "$JOURNAL" |
  grep -i "authentication failure" || true)

COUNT=$(printf '%s\n' "$EVENTS" |
  grep -ic "authentication failure")

SCAN_TIME=$(date '+%Y-%m-%d %H:%M:%S %Z')

if [ "$COUNT" -ge 3 ]; then
    STATUS="ALERT"
elif [ "$COUNT" -ge 1 ]; then
    STATUS="NOTICE"
else
    STATUS="OK"
fi

echo "=================================="
echo " LINUX AUTHENTICATION MONITOR"
echo "=================================="
echo "Scan Time: $SCAN_TIME"
echo "Window: $WINDOW"
echo "Failures Detected: $COUNT"
echo "Status: $STATUS"
echo "----------------------------------"
echo "EVENT EVIDENCE"

if [ "$COUNT" -gt 0 ]; then
    printf '%s\n' "$EVENTS"
else
    echo "No matching events found."
fi

echo "=================================="

