# stunnel

Dockerfile to build an stunnel docker container.

## Lets Encrypt

Let's Encrypt provides you with an SSL certificate that is signed by 
a nonprofit certificate authority, so it is free for everyone.

The Let's Encrypt procedure results in a set of four key files,
contained in `/etc/letsencrypt/live/domain.com/`:

```plain
$ ls /etc/letsencrypt/live/domain.com/
README
cert.pem@	 --> /etc/letsencrypt/archive/domain.com/cert2.pem
chain.pem@	 --> /etc/letsencrypt/archive/domain.com/chain2.pem
fullchain.pem@	 --> /etc/letsencrypt/archive/domain.com/fullchain2.pem
privkey.pem@	 --> /etc/letsencrypt/archive/domain.com/privkey2.pem
```

We will use the following two keys (descriptions from README): 

```plain
`privkey.pem`  : the private key for your certificate.
`fullchain.pem`: the certificate file used in most server software.
```

## Lets Encrypt to Docker Container

Copy these to the directory where you will be spawning the Docker containers. We make copies because the Let's Encrypt keys are owned by root and we want to keep them that way, and also we want a portable key solution.

```plain
$ sudo cp /etc/letsencrypt/live/domain.com/{privkey.pem,fullchain.pem} /home/zappa/docker/stunnel/.
$ sudo chown zappa:zappa /home/zappa/docker/stunnel/*.pem
$ sudo chmod 600 /hom/ezappa/docker/stunnel/*.pem
```

The Dockerfile will copy these two .pem files into the Docker container when it is being built.

## Docker Container Test

Now, stunnel is supposed to start automatically when the container is created, but we can test if the Docker container and the stunnel command actually worked by starting a bash shell. When you get the shell, run the stunnel command.

```plain
$ docker run -ti cmr_stunnel /bin/bash
root@c9b9b1f0ce80:/# stunnel
stunnel: LOG5[ui]: stunnel 5.30 on x86_64-pc-linux-gnu platform
stunnel: LOG5[ui]: Compiled with OpenSSL 1.0.2e 3 Dec 2015
stunnel: LOG5[ui]: Running  with OpenSSL 1.0.2g  1 Mar 2016
stunnel: LOG5[ui]: Update OpenSSL shared libraries or rebuild stunnel
stunnel: LOG5[ui]: Threading:PTHREAD Sockets:POLL,IPv6,SYSTEMD TLS:ENGINE,FIPS,OCSP,PSK,SNI Auth:LIBWRAP
stunnel: LOG5[ui]: Reading configuration from file /etc/stunnel/stunnel.conf
stunnel: LOG5[ui]: UTF-8 byte order mark not detected
stunnel: LOG5[ui]: FIPS mode disabled
stunnel: LOG4[ui]: Insecure file permissions on /etc/stunnel/stunnel.key.pem
stunnel: LOG4[ui]: Service [http] needs authentication to prevent MITM attacks
stunnel: LOG5[ui]: Configuration successful
root@c9b9b1f0ce80:/#
```










