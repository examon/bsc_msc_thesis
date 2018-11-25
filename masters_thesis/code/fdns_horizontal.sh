#!/bin/bash

# fdns_horizontal.sh
# ~~~~~~~~~~~~~~~~~~
# Patrik Hudak, 2017
# As part of 'Analysis of DNS in cybersecurity' master thesis
# ~~~~~~~~~~~~~~~~~~

display_usage() { 
	echo "This script finds all related domains based on NS records in the FDNS dataset" 
	echo -e "\nUsage: ./fdns_horizontal.sh FDNS_DATASET DOMAIN_NAME"
	echo -e "Example: ./fdns_horizontal.sh 20171020-fdns.json.gz example.com" 
} 

if [ $# -ne 2 ]; then
	display_usage;
	exit 1;
fi 
 
if [[ ($# == '--help') ||  $# == '-h' ]]; then 
	display_usage;
	exit 0;
fi

NS_FILE=$(mktemp);
REGEX="${2/./[.]}"

zcat $1 |
grep -F ".$2\"" | 
jq -crM 'if (.name | test("[.]'"$REGEX"'$")) then . else empty end' | 
jq -crM 'if .type == "ns" then .value else empty end' | 
sort | 
uniq | 
grep -E '[.]'"$REGEX"'$' > NS_FILE

zcat $1 |
grep -F ".$2\"" | 
jq -crM 'if .type == "ns" then . else empty end' |
python ns_group.py NS_FILE | 
python base_domain.py |
sort |
uniq 

rm -f NS_FILE
