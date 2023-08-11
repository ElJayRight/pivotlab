# Quick reference

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
