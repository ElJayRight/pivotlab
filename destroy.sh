echo "=== Stopping and deleting containers ==="
sudo docker rm admin_box internal_box public_box -f

echo "=== Removing docker networks ==="
sudo docker network prune -f
