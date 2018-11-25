#!/usr/bin/env python

# tld_extract.py
# ~~~~~~~~~~~~~~~~~~
# Patrik Hudak, 2017
# As part of 'Analysis of DNS in cybersecurity' Master's Thesis
# ~~~~~~~~~~~~~~~~~~

from __future__ import print_function

import json
import sys

import tldextract

def get_tld(domain):
    """
    Returns base domain of given domain

    subsub.sub.example.com -> example.com
    """

    parsed = tldextract.extract(domain)
    return parsed.suffix
    
if __name__ == '__main__':
    for domain in sys.stdin:
        if not domain.strip():
            continue

        print(get_tld(domain.strip()))
