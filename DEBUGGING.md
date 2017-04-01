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

## Nmap

Note that nmap does not seem to be a consistent way of finding whether 
the port has been successfully mapped. Even if the port 
does not show up as open on an nmap scan, you may still be able to poke it remotely.

(Now to test out whether stunnel works with negative nmap scans.)




