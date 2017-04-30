FROM ubuntu
MAINTAINER charles@charlesreid1.com

RUN mkdir -p /etc/stunnel
VOLUME ["/etc/stunnel"]

ADD stunnel.conf /etc/stunnel/stunnel.conf
ADD fullchain.pem /etc/stunnel/stunnel.fullchain.pem
ADD privkey.pem /etc/stunnel/stunnel.key.pem

ADD start_stunnel.sh /start_stunnel.sh

RUN apt-get update
RUN apt-get -y install stunnel
RUN apt-get -y install net-tools
RUN chmod 600 /etc/stunnel/stunnel.fullchain.pem
RUN chmod 600 /etc/stunnel/stunnel.key.pem

CMD ["/start_stunnel.sh"]

