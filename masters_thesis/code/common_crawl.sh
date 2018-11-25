#!/bin/bash

# common_crawl.sh
# ~~~~~~~~~~~~~~~~~~
# Patrik Hudak, 2017
# As part of 'Analysis of DNS in cybersecurity' master thesis
# ~~~~~~~~~~~~~~~~~~

display_usage() { 
	echo "This script finds all domains in SAN field of TLS/SSL certificate\nList of API endpoints: http://index.commoncrawl.org/" 
	echo -e "\nUsage: ./common_crawl.sh INDEX_API_ENDPOINT DOMAIN_NAME"
	echo -e "Example: ./common_crawl.sh CC-MAIN-2017-39-index example.com"
} 

if [ $# -ne 2 ]; then
	display_usage;
	exit 1;
fi 
 
if [[ ($# == '--help') ||  $# == '-h' ]]; then 
	display_usage;
	exit 0;
fi

http -b BODY "http://index.commoncrawl.org/$1/coll-cdx?url=*.$2&output=json" | jq -crM '.url' | awk -F/ '{print $3}' | awk -F\? '{print $1}' | sort | uniq
