#!/bin/bash

# san.sh
# ~~~~~~~~~~~~~~~~~~
# Patrik Hudak, 2017
# As part of 'Analysis of DNS in cybersecurity' master thesis
# ~~~~~~~~~~~~~~~~~~

display_usage() { 
	echo "This script finds all domains in SAN field of TLS/SSL certificate" 
	echo -e "\nUsage: ./san.sh DOMAIN_NAME" 
} 

if [ $# -ne 1 ]; then
	display_usage;
	exit 1;
fi 
 
if [[ ($# == '--help') ||  $# == '-h' ]]; then 
	display_usage;
	exit 0;
fi

true | openssl s_client -servername $1 -connect $1:443 | openssl x509 -noout -text | grep -Eo 'DNS:[^,]+' | cut -c5-