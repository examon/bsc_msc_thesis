#!/usr/bin/env python

# base_domain.py
# ~~~~~~~~~~~~~~~~~~
# Patrik Hudak, 2017
# As part of 'Analysis of DNS in cybersecurity' master thesis
# ~~~~~~~~~~~~~~~~~~

from __future__ import print_function

import json
import sys

import tldextract

def get_base_domain(domain):
    """
    Return base domain of given domain

    subsub.sub.example.com -> example.com
    """

    parsed = tldextract.extract(domain)
    return '{0}.{1}'.format(parsed.domain, parsed.suffix)
    
if __name__ == '__main__':
    for domain in sys.stdin:
        if not domain.strip():
            continue

        print(get_base_domain(domain.strip()))
