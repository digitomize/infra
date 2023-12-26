sudo apt update
sudo apt upgrade

# Add Docker's official GPG key:
sudo apt-get -y update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -y -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get -y update


sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker swarm init

sudo usermod -aG docker $USER

curl -s https://install.meltred.tech/meltcd | bash

sudo apt install -y nginx 

sudo touch /etc/nginx/sites-enabled/meltcd.digitomize.com
sudo touch /etc/nginx/sites-enabled/api.digitomize.com

echo "server { listen 80; server_name meltcd.digitomize.com; location / { proxy_pass http://127.0.0.1:11771; } }" | sudo tee /etc/nginx/sites-enabled/meltcd.digitomize.com
echo "server { listen 80; server_name api.digitomize.com; location / { proxy_pass http://127.0.0.1:4001; } }" | sudo tee /etc/nginx/sites-enabled/api.digitomize.com

sudo nginx -s reload

sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot

echo "####"
echo "####"
echo "####"
echo "Setup Digitomize Infra"
echo "Add a DNS Record for meltcd.digitomize.com to Public IP Address"
echo "Add a DNS Record for api.digitomize.com to Public IP Address"
echo "---------------"
echo "And run \"sudo certbot --nginx -d meltcd.digitomize.com\" "
echo "And run \"sudo certbot --nginx -d api.digitomize.com\" "
echo "####"
echo "####"
echo "####"
