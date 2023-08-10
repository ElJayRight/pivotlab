echo "=== Stopping and deleting containers ==="
sudo docker stop admin_box internal_box public_box
sudo docker rm admin_box internal_box public_box

echo "=== Removing docker networks ==="
sudo docker network prune -f
