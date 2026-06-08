#!/bin/bash

REPORT_FILE="network_report.txt"

# Clear old report
> "$REPORT_FILE"

# Function to display and save output
log() {
    echo "$1" | tee -a "$REPORT_FILE"
}

log " ====================================="
log "|      NETWORK HEALTH CHECK REPORT   |"
log " ====================================="

# 1. Server Information
log ""
log "SERVER INFORMATION"
log "------------------"
log "Hostname      : $(hostname)"
log "Current User  : $(whoami)"
log "Date & Time   : $(date)"

# 2. Network Information
log ""
log "NETWORK INFORMATION"
log "-------------------"

IP_ADDRESS=$(hostname -I | awk '{print $1}')
DEFAULT_GATEWAY=$(ip route | grep default | awk '{print $3}')
DNS_SERVER=$(grep "nameserver" /etc/resolv.conf | awk '{print $2}' | head -1)

log "IP Address      : $IP_ADDRESS"
log "Default Gateway : $DEFAULT_GATEWAY"
log "DNS Server      : $DNS_SERVER"

# 3. Internet Connectivity Check
log ""
log "INTERNET CONNECTIVITY"
log "---------------------"

if ping -c 4 8.8.8.8 > /dev/null 2>&1
then
    log "Internet Connectivity : UP"
else
    log "Internet Connectivity : DOWN"
fi

# 4. DNS Resolution Check
log ""
log "DNS RESOLUTION"
log "--------------"

if nslookup google.com > /dev/null 2>&1
then
    log "DNS Resolution : WORKING"
else
    log "DNS Resolution : FAILED"
fi

# 5. Website Availability Check
log "WEBSITE AVAILABILITY"
log "--------------------"

for site in google.com github.com amazon.com
do
    if ping -c 2 "$site" > /dev/null 2>&1
    then
        log "$site : UP"
    else
        log "$site : DOWN"
    fi
done

log ""
log "Report saved to: $REPORT_FILE"