#!/bin/bash

# fdns_vertical.sh
# ~~~~~~~~~~~~~~~~~~
# Patrik Hudak, 2017
# As part of 'Analysis of DNS in cybersecurity' master thesis
# ~~~~~~~~~~~~~~~~~~

display_usage() { 
	echo "This script finds all subdomains in the FDNS dataset" 
	echo -e "\nUsage: ./fdns_vertical.sh FDNS_DATASET DOMAIN_NAME"
	echo -e "Example: ./fdns_vertical.sh 20171020-fdns.json.gz example.com" 
} 

if [ $# -ne 2 ]; then
	display_usage;
	exit 1;
fi 
 
if [[ ($# == '--help') ||  $# == '-h' ]]; then 
	display_usage;
	exit 0;
fi

REGEX="${2/./[.]}"
zcat $1 | grep -F ".$2\"" | jq -crM 'if (.name | test("[.]'"$REGEX"'$")) then .name else empty end' | sort | uniq