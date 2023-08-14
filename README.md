=== Instructions ===
1. Run the setup.sh script:

chmod +x ./setup.sh
./setup.sh

2. Activate virtual environment:

source .venv/bin/activate

3. Build the lab:

chmod +x build.sh

./build.sh


=== Goals ===
1. Get access to the public box.
2. Use a reverse port forward to access the webserver listening on port 8080
3. Create a socks proxy to access the internal network and ssh into the internal box.
4. Create a chained socks proxy to access the admin network and ssh into the admin box.
5. Using chisel create a tunnel back to your host machine so you can access the local listening website on the admin box
