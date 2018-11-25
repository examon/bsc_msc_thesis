#!/bin/bash

# ip_range.sh
# ~~~~~~~~~~~~~~~~~~
# Patrik Hudak, 2017
# As part of 'Analysis of DNS in cybersecurity' master thesis
# ~~~~~~~~~~~~~~~~~~

display_usage() { 
	echo "This script finds all domains which have A records set to the IP address from specified IP range." 
	echo -e "\nUsage: ./ip_range.sh FDNS_DATASET IP_RANGE"
} 

if [ $# -ne 2 ]; then
	display_usage;
	exit 1;
fi 
 
if [[ ($# == '--help') ||  $# == '-h' ]]; then 
	display_usage;
	exit 0;
fi

# returns unique list of domains pointing to the specified IP range
zcat $1 | 
grepcidr $2 | 
jq -crM 'if .type == "a" then .name else empty end' | 
python base_domain.py | 
sort | 
uniq
