FROM ubuntu

RUN mkdir -p /etc/stunnel
VOLUME ["/etc/stunnel"]

ADD stunnel.conf /etc/stunnel/stunnel.conf
ADD fullchain.pem /etc/stunnel/stunnel.fullchain.pem
ADD privkey.pem /etc/stunnel/stunnel.key.pem

RUN apt-get update
RUN apt-get -y install stunnel

CMD ["stunnel"]

