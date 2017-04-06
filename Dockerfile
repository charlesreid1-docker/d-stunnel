FROM ubuntu

RUN mkdir -p /etc/stunnel
VOLUME ["/etc/stunnel"]

ADD stunnel.conf /etc/stunnel/stunnel.conf
ADD fullchain.pem /etc/stunnel/stunnel.fullchain.pem
ADD privkey.pem /etc/stunnel/stunnel.key.pem

RUN apt-get update
RUN apt-get -y install stunnel
RUN apt-get -y install net-tools
RUN chmod 600 /etc/stunnel/stunnel.fullchain.pem
RUN chmod 600 /etc/stunnel/stunnel.key.pem
############ 
# Add if we are doing rsync. port should be stunnel port.
#RUN echo "ssyncd 443/tcp # secure rsync over stunnel" >> /etc/services
############ 

CMD ["/usr/bin/stunnel"]

