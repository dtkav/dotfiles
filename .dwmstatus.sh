#!/bin/bash
while true; do
    battery=$(acpi -b | grep -v 'rate information unavailable' | cut -d"," -f2 | cut -d" " -f2)
    charge_state=$(acpi -b | grep -v 'rate information unavailable' | grep "Discharging"; echo "$?")
    batt_pct=$(acpi -b | grep -v 'rate information unavailable' | grep 'Discharging' | sed 's/^.*Discharging.*\([ 0-9][0-9]\)%.*$/\1/g')
    if [[ ! -z $batt_pct ]]; then
        if [[ $batt_pct < 40 ]]; then
            notify-send 'low on juice' 'PLUG ME IN'
        fi
    fi
    ip=$(ip addr  show dev wlp58s0 | grep 'inet ' | awk '{print $2}')
    ip="wlp58s0:${ip}"
    xsetroot -name " $battery  $ip  $(date +"%r") ($(date -u +"%Y-%m-%dT%H:%MZ"))"
    sleep 30
done
