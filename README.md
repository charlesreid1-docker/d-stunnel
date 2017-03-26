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

## Docker Conatiner Test

Now, stunnel is supposed to start automatically when the container is created, but we can test if the Docker container and the stunnel command actually worked by starting a bash shell.

```plain
$ docker run -ti cmr_stunnel /bin/bash
```










