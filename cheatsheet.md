# Quick reference Chisel

## Start chisel server:

```bash
./chisel server --reverse --port <port_number> [--socks5]
```

## Connect to server

```bash
./chisel client <server_ip>:<server_port> R:[socks | 127.0.0.1:<remoteport>:<localport>]
```

## Proxychains config

If you do this

```bash
./chisel client <server_ip>:<server_port> R:<port>:socks
```

Then you have to add this:

```bash
socks5  127.0.0.1 <port>
```

to:

```bash
/etc/proxychains.conf
```

# Quick Reference SSH

To open ssh prompt

```bash
~C
```

## Port forward

To forward a port form one end of the ssh connection to another (this is so much better than chisel if you have ssh)

```bash
ssh> -L <remote_port>:localhost:<localport>
```

## Socks proxy

```bash
ssh> -D<port>
```