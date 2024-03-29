echo "Update your package manager"
sudo apt-get update

echo "Installing LAMP"
echo "Install Apache"
sudo apt-get install apache2 -y

echo "Install PHP"
sudo apt-get install php -y

echo "Move files to apache file location"
sudo cp server/*.php /var/www/html

echo "Install MySQL"
sudo apt-get install mariadb-server php-mysql -y

echo "Running MySQL config..."
sudo mysql_secure_installation

echo "Initialize database"
sudo mysql -u root -p < server/initialize_db.sql
echo "Database is initialized!"

echo "Install Grafana"
sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

sudo apt-get install grafana -y

sudo systemctl enable grafana-server
sudo systemctl start grafana-server
sudo grafana-cli plugins install grafana-worldmap-panel

echo "Restart services"
sudo service mysql restart
sudo service apache2 restart
sudo service grafana-server restart
