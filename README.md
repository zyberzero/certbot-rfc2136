# Using certbot (Let's encrypt) with RFC2136

Some servers are unable to have a web server installed, but can still make use of a certificate (for example, mail servers).
These scripts automates the authentication and clean up using DNS for validation. 

## Installation

clone this repo, or download the files.
Update the files with the data necessary, such as zone name, name server and path to your key-file.

Your server needs nsupdate, which at least on debian is in the bind9utils package. You also need to create a keypair that you use for validate that you have the right to update the zone data.

Create your key by using `dnssec-keygen`, for example:
`$ dnssec-keygen -a HMAC-MD5 -b 512 -n USER keyname`
This will create to files, a .private, and a .key file. Upload the key file to your DNS administrator, or set up bind as per below. The .private file is, as the name implies, supposed to be private as anyone with that file can update your DNS zone. This is also the file that you should point out by the scripts.

Then, setup certbot;
```sudo certbot certonly --preferred-challenges=dns --manual --manual-auth-hook /usr/sbin/certbot-auth.sh  --manual-cleanup-hook /usr/sbin/certbot-clean.sh -d yourdomain.tld --manual-public-ip-logging-ok```

It will then verify your domain, and then download the certificate. Afterwards, `sudo certbot renew` will update the certificate. Use a renew hook if you want to do something after renewal, such as reloading postfix, or whatever service that uses the certificates.

## BIND installation
I'm running BIND on my DNS servers, and followed [this guide] (http://linux.yyz.us/dns/ddns-server.html) to set it up.


