#!/bin/bash
while true; do
    battery=$(acpi -b | cut -d"," -f2 | cut -d" " -f2)
    ip=$(ip addr  show dev wlp58s0 | grep 'inet ' | awk '{print $2}')
    ip="wlp58s0:${ip}"
    xsetroot -name " $battery  $ip  $(date +"%r") ($(date -u +"%Y-%m-%dT%H:%MZ"))"
    sleep 30
done
