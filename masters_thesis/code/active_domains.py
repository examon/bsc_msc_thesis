#!/usr/bin/env python

# data_analysis.sh
# ~~~~~~~~~~~~~~~~~~
# Patrik Hudak, 2017
# As part of 'Analysis of DNS in cybersecurity' master thesis
# ~~~~~~~~~~~~~~~~~~

import dns.exception
import dns.message
import dns.rdatatype
import dns.resolver
import requests

RESOLVERS = [
    # Google DNS
    '8.8.8.8',
    '8.8.4.4',

    # DNS.Watch
    '84.200.69.80',
    '84.200.70.40',

    # OpenDNS
    '208.67.222.222',
    '208.67.220.220'
]

def resolve(domain, rr=dns.rdatatype.ANY, resolvers=None):
    """
    Send DNS request without any error handling

    :param domain: Domain to resolve
    :param rr: Resource Record type (ANY by default)
    :return: DNS Answer
    """

    if not resolvers:
        resolvers = RESOLVERS

    custom_resolver = dns.resolver.Resolver()
    custom_resolver.nameservers = resolvers
    q = custom_resolver.query(domain, rr)
    answers = q.response.answer

    if len(answers) > 0:
        return answers

    return None

def is_error(domain):
    """
    Checks if given domain responds with DNS errors

    :param domain: Domain to check
    :return: True if domain is throws DNS error, False otherwise
    """

    try:
        # try to resolve A and check response
        resolve(domain, 'A')
    except dns.exception.DNSException:
        return True

    return False

if __name__ == '__main__':
    for domain in sys.stdin:
        domain = domain.strip()
        if is_error(domain):
            continue

        print(domain)
