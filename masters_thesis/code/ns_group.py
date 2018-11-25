#!/usr/bin/env python

# ns_group.py
# ~~~~~~~~~~~~~~~~~~
# Patrik Hudak, 2017
# As part of 'Analysis of DNS in cybersecurity' master thesis
# ~~~~~~~~~~~~~~~~~~

from __future__ import print_function

import json
import sys

if __name__ == '__main__':
	if len(sys.argv) != 2:
		print('Usage: ./ns_group.py NAMESERVER_LIST')
		sys.exit(1)

	with open(sys.argv[1]) as fr:
		nameservers = fr.read().split('\n')

	for record in sys.stdin:
		p_record = json.loads(record)
		if p_record['value'] in nameservers:
			print(p_record['name'])
