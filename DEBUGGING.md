# Debugging

## Better Monitoring

To debug an stunnel connection, add two lines to your stunnel.conf:

```
debug = 7
foreground = yes
```

These will print helpful information to the console and make debugging 
and troubleshooting much easier.

## Using Telnet

Once you have the console showing a stream of information about stunnel
and its current status, you can give it a poke using telnet:

```
telnet <remote IP> 273
```

This should result in a connection on port 273 being opened.
To exit, keep pressing enter or entering input until the connection closes.

If you can successfully poke it, that means your stunnel service 
is actively listening and making it through the firewall.
(If you are using Docker, it also means you have correctly mapped ports
from inside the container to the host machine.)

## Nmap On Server

Note that nmap does not seem to be a consistent way of finding whether 
the port has been successfully mapped. Even if the port 
does not show up as open on an nmap scan, you may still be able to poke it remotely.

(Now to test out whether stunnel works with negative nmap scans.)

# Rsync

Followed all instructions, but getting this error:

```
$ /usr/local/bin/rsync -vv localhost::
opening tcp connection to localhost port 873
rsync: safe_read failed to read 1 bytes [Receiver]: Connection reset by peer (54)
rsync error: error in rsync protocol data stream (code 12) at io.c(276) [Receiver=3.1.2]
```

The output on the server end showed that the server was unable to contact anything at port 127.0.0.1:873:

```
stunnel: LOG6[0]: failover: round-robin, starting at entry #0
2017.04.01 05:44:30 LOG6[0]: failover: round-robin, starting at entry #0
stunnel: LOG6[0]: s_connect: connecting ::1:873
2017.04.01 05:44:30 LOG6[0]: s_connect: connecting ::1:873
stunnel: LOG7[0]: s_connect: s_poll_wait ::1:873: waiting 10 seconds
2017.04.01 05:44:30 LOG7[0]: s_connect: s_poll_wait ::1:873: waiting 10 seconds
stunnel: LOG3[0]: s_connect: connect ::1:873: Connection refused (111)
2017.04.01 05:44:30 LOG3[0]: s_connect: connect ::1:873: Connection refused (111)
stunnel: LOG6[0]: s_connect: connecting 127.0.0.1:873
2017.04.01 05:44:30 LOG6[0]: s_connect: connecting 127.0.0.1:873
stunnel: LOG7[0]: s_connect: s_poll_wait 127.0.0.1:873: waiting 10 seconds
2017.04.01 05:44:30 LOG7[0]: s_connect: s_poll_wait 127.0.0.1:873: waiting 10 seconds
stunnel: LOG3[0]: s_connect: connect 127.0.0.1:873: Connection refused (111)
2017.04.01 05:44:30 LOG3[0]: s_connect: connect 127.0.0.1:873: Connection refused (111)
stunnel: LOG5[0]: Connection reset: 0 byte(s) sent to SSL, 0 byte(s) sent to socket
2017.04.01 05:44:30 LOG5[0]: Connection reset: 0 byte(s) sent to SSL, 0 byte(s) sent to socket
stunnel: LOG7[0]: Local descriptor (FD=3) closed
2017.04.01 05:44:30 LOG7[0]: Local descriptor (FD=3) closed
stunnel: LOG7[0]: Service [rsync] finished (0 left)
2017.04.01 05:44:30 LOG7[0]: Service [rsync] finished (0 left)
```

This took a brief detour, installing stunnel and getting it configured.
Once you start the stunnel service via the unix services,
you are ready to rock and roll.

Docker container running stunnel running on remote server.
Rsync running on remote server.
Stunnel running on client end.

Test out the connection:

```
rsync -vv localhost::
```

Success!

On the client:

```plain
[client] $ $ rsync -vv localhost::
opening tcp connection to localhost port 873
sending daemon args: --server --sender -vvde.LsfxC . /  (5 args)
pi             	Raspberry Pi Wifi Data
```

On the server (monitoring the status of stunnel on the console):

```
stunnel: LOG7[ui]: Found 1 ready file descriptor(s)
2017.04.01 06:25:32 LOG7[ui]: Found 1 ready file descriptor(s)
stunnel: LOG7[ui]: FD=4 events=0x2001 revents=0x0
2017.04.01 06:25:32 LOG7[ui]: FD=4 events=0x2001 revents=0x0
stunnel: LOG7[ui]: FD=6 events=0x2001 revents=0x1
2017.04.01 06:25:32 LOG7[ui]: FD=6 events=0x2001 revents=0x1
stunnel: LOG7[ui]: Service [rsync] accepted (FD=3) from 98.8.8.133:60785
2017.04.01 06:25:32 LOG7[ui]: Service [rsync] accepted (FD=3) from 98.8.8.133:60785
stunnel: LOG7[1]: Service [rsync] started
2017.04.01 06:25:32 LOG7[1]: Service [rsync] started
stunnel: LOG5[1]: Service [rsync] accepted connection from 98.8.8.133:60785
2017.04.01 06:25:32 LOG5[1]: Service [rsync] accepted connection from 98.8.8.133:60785
stunnel: LOG7[1]: SSL state (accept): before/accept initialization
2017.04.01 06:25:32 LOG7[1]: SSL state (accept): before/accept initialization
stunnel: LOG7[1]: SNI: no virtual services defined
2017.04.01 06:25:32 LOG7[1]: SNI: no virtual services defined
stunnel: LOG7[1]:      2 server accept(s) requested
2017.04.01 06:25:32 LOG7[1]:      2 server accept(s) requested
stunnel: LOG7[1]:      2 server accept(s) succeeded
2017.04.01 06:25:32 LOG7[1]:      2 server accept(s) succeeded
stunnel: LOG7[1]:      0 server renegotiation(s) requested
2017.04.01 06:25:32 LOG7[1]:      0 server renegotiation(s) requested
stunnel: LOG7[1]:      1 session reuse(s)
2017.04.01 06:25:32 LOG7[1]:      1 session reuse(s)
stunnel: LOG7[1]:      1 internal session cache item(s)
2017.04.01 06:25:32 LOG7[1]:      1 internal session cache item(s)
stunnel: LOG7[1]:      0 internal session cache fill-up(s)
2017.04.01 06:25:32 LOG7[1]:      0 internal session cache fill-up(s)
stunnel: LOG7[1]:      1 internal session cache miss(es)
2017.04.01 06:25:32 LOG7[1]:      1 internal session cache miss(es)
stunnel: LOG7[1]:      0 external session cache hit(s)
2017.04.01 06:25:32 LOG7[1]:      0 external session cache hit(s)
stunnel: LOG7[1]:      0 expired session(s) retrieved
2017.04.01 06:25:32 LOG7[1]:      0 expired session(s) retrieved
stunnel: LOG6[1]: SSL accepted: previous session reused
2017.04.01 06:25:32 LOG6[1]: SSL accepted: previous session reused
stunnel: LOG6[1]: persistence: 127.0.0.1:873 reused
2017.04.01 06:25:32 LOG6[1]: persistence: 127.0.0.1:873 reused
stunnel: LOG6[1]: s_connect: connecting 127.0.0.1:873
2017.04.01 06:25:32 LOG6[1]: s_connect: connecting 127.0.0.1:873
stunnel: LOG7[1]: s_connect: s_poll_wait 127.0.0.1:873: waiting 10 seconds
2017.04.01 06:25:32 LOG7[1]: s_connect: s_poll_wait 127.0.0.1:873: waiting 10 seconds
stunnel: LOG5[1]: s_connect: connected 127.0.0.1:873
2017.04.01 06:25:32 LOG5[1]: s_connect: connected 127.0.0.1:873
stunnel: LOG6[1]: persistence: 127.0.0.1:873 cached
2017.04.01 06:25:32 LOG6[1]: persistence: 127.0.0.1:873 cached
stunnel: LOG5[1]: Service [rsync] connected remote server from 127.0.0.1:37562
2017.04.01 06:25:32 LOG5[1]: Service [rsync] connected remote server from 127.0.0.1:37562
stunnel: LOG7[1]: Remote descriptor (FD=8) initialized
2017.04.01 06:25:32 LOG7[1]: Remote descriptor (FD=8) initialized
stunnel: LOG6[1]: Read socket closed (readsocket)
2017.04.01 06:25:32 LOG6[1]: Read socket closed (readsocket)
stunnel: LOG7[1]: Sending close_notify alert
2017.04.01 06:25:32 LOG7[1]: Sending close_notify alert
stunnel: LOG7[1]: SSL alert (write): warning: close notify
2017.04.01 06:25:32 LOG7[1]: SSL alert (write): warning: close notify
stunnel: LOG6[1]: SSL_shutdown successfully sent close_notify alert
2017.04.01 06:25:32 LOG6[1]: SSL_shutdown successfully sent close_notify alert
stunnel: LOG7[1]: SSL alert (read): warning: close notify
2017.04.01 06:25:32 LOG7[1]: SSL alert (read): warning: close notify
stunnel: LOG6[1]: SSL closed (SSL_read)
2017.04.01 06:25:32 LOG6[1]: SSL closed (SSL_read)
stunnel: LOG7[1]: Sent socket write shutdown
2017.04.01 06:25:32 LOG7[1]: Sent socket write shutdown
stunnel: LOG5[1]: Connection closed: 67 byte(s) sent to SSL, 15 byte(s) sent to socket
2017.04.01 06:25:32 LOG5[1]: Connection closed: 67 byte(s) sent to SSL, 15 byte(s) sent to socket
stunnel: LOG7[1]: Remote descriptor (FD=8) closed
2017.04.01 06:25:32 LOG7[1]: Remote descriptor (FD=8) closed
stunnel: LOG7[1]: Local descriptor (FD=3) closed
2017.04.01 06:25:32 LOG7[1]: Local descriptor (FD=3) closed
stunnel: LOG7[1]: Service [rsync] finished (0 left)
2017.04.01 06:25:32 LOG7[1]: Service [rsync] finished (0 left)
```

