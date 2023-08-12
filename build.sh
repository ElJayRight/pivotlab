echo "=== Building the lab ==="
python3 -m pip install ansible-core
ansible-galaxy collection install community.docker
ansible-playbook playbook.yml

echo "=== Adding iptables rules ==="
sudo iptables -A INPUT -s 10.10.16.3 -j DROP
sudo iptables -A OUTPUT -s 10.10.16.3 -j DROP

sudo iptables -A INPUT -s 10.10.4.3 -j DROP
sudo iptables -A INPUT -s 10.10.4.3 -j DROP

echo "=== LAB INFO ==="
sudo docker inspect public_box| grep IPAddress|tail -1 | awk -F\" '{print "Entry point: " $4}'
echo "Credentials:"
echo "  - public_box -> danny:danny"
echo "  - internal_box -> ariana:Password1"
echo "  - admin_box -> jack:Complexpassword123#"
