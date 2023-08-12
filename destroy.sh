echo "=== Stopping and deleting containers ==="
sudo docker rm admin_box internal_box public_box -f

echo "=== Removing docker networks ==="
sudo docker network prune -f

echo "=== Removing verified keys ==="
ssh-keygen -f "/home/eljay/.ssh/known_hosts" -R "10.10.16.3"
ssh-keygen -f "/home/eljay/.ssh/known_hosts" -R "10.10.4.3"
ssh-keygen -f "/home/eljay/.ssh/known_hosts" -R "192.168.69.2"

echo "=== Removing iptable rules ==="
sudo iptables -D INPUT -s 10.10.16.3 -j DROP
sudo iptables -D OUTPUT -s 10.10.16.3 -j DROP

sudo iptables -D INPUT -s 10.10.4.3 -j DROP
sudo iptables -D INPUT -s 10.10.4.3 -j DROP
