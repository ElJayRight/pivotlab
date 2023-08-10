python3 -m pip install ansible-core
ansible-galaxy collection install community.docker
ansible-playbook playbook.yml

sudo docker inspect public_box| grep IPAddress|tail -1 | awk -F\" '{print "Entry point: " $4}'
echo "Credentials:"
echo "  - public_box -> danny:danny"
echo "  - internal_box -> ariana:Password1"
echo "  - admin_box -> jack:Complexpassword123#"
