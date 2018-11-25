#!/bin/bash

# data_analysis.sh
# ~~~~~~~~~~~~~~~~~~
# Patrik Hudak, 2017
# As part of 'Analysis of DNS in cybersecurity' master thesis
# ~~~~~~~~~~~~~~~~~~

display_usage() { 
	echo "This script does a basic statistics on top of FDNS." 
	echo -e "\nUsage: ./data_analysis.sh FDNS_DATASET"
} 

if [ $# -ne 1 ]; then
	display_usage;
	exit 1;
fi 
 
if [[ ($# == '--help') ||  $# == '-h' ]]; then 
	display_usage;
	exit 0;
fi

# Breakdown by record types
echo -e "Record types analysis"
zcat $1 | jq -r '.type' | sort | uniq -c | sort -nr > record_types.txt
echo -e "Record types statistics saved to ./record_types.txt"

# Breakdown by domains
# zcat $1 | jq -r '.name' | sort | uniq > domains.txt

# Breakdown by base domains
echo -e "Base domains analysis"
zcat $1 | jq -r '.name' | python base_domain.py | sort | uniq > base_domains.txt
echo -e "Based domains saved to ./base_domains.txt"

# Breakdown by TLD
echo -e "TLD analysis"
cat base_domains.txt | python tld_extract.py | sort | uniq -c | sort -nr > tlds.txt
echo -e "TLDs saved to ./tlds.txt"

# Breakdown by CNAME
echo -e "CNAME analysis"
zcat $1 | jq -r 'if .type == "cname" then .value else empty end' | python base_domain.py | sort | uniq -c | sort -nr > cnames.txt
echo -e "CNAMES saved to ./cnames.txt"
