#!/bin/bash
# 
# Generate a self-signed certificate
# You snake oil salesman you
# 
# https://charlesreid1.com/wiki/RaspberryPi/SSH_Stunnel

# Use the openssl library to generate a 2048-bit private RSA key:
openssl genrsa -out key.pem 2048

#  already generated a private key, so now we generate a certificate, and use our own key to sign it
openssl req -new -x509 -key key.pem -out cert.pem -days 365

# Now you have your private key in key.pem and your server's certificate in cert.pem.

# Put those both into the certificate file:
cat key.pem cert.pem >> stunnel.pem

