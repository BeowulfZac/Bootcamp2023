#inicio
sudo apt update
sudo apt install git -y
echo ****apache instalacion****
if [[ -z $(apache2 -v 2>/dev/null) ]] && [[ -z $(httpd -v 2>/dev/null) ]]; then sudo apt install apache2 -y;
sudo ufw allow in "Apache" ; fi
echo ****FIN apache instalacion****
echo ****MariaDbSErver instalacion****
if [[ -z $(mariadb-server -v 2>/dev/null) ]]; then 
sudo apt install -y mariadb-server 
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo systemctl status mariadb
 fi
echo ****FIN Mysql instalacion****
echo ****PHP , PHP libs instalacion****
if [[ -z $(php -v 2>/dev/null) ]];   then sudo apt install -y php;  fi
echo ****FIN PHP , PHP libs instalacion****
# Verificar si libapache2-mod-php ya está instalado
dpkg -l | grep libapache2-mod-php > /dev/null
if [ $? -eq 0 ]; then
    echo "libapache2-mod-php ya está instalado."
else
    # Instalar libapache2-mod-php
    echo "Instalando libapache2-mod-php..."
    apt-get update
    apt-get install -y libapache2-mod-php
    echo "Instalación de libapache2-mod-php completada."
fi

# Verificar si php-mysql ya está instalado
dpkg -l | grep php-mysql > /dev/null
if [ $? -eq 0 ]; then
    echo "php-mysql ya está instalado."
else
    # Instalar php-mysql
    echo "Instalando php-mysql..."
    apt-get update
    apt-get install -y php-mysql
    echo "Instalación de php-mysql completada."
fi
sudo mkdir /var/www/prueba1
#sudo chown -R www-data:$USER /var/www/prueba1
sudo chown -R www-data:root /var/www/prueba1
echo "<VirtualHost *:80>
    ServerName prueba1
    ServerAlias www.prueba1
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/prueba1
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/prueba1.conf 
sudo a2ensite prueba1
sudo systemctl reload apache2
touch  /var/www/prueba1/index.html
echo  "<h1>It works...</h1><p>This is the landing page of <strong>prueba1</strong>.</p>" > /var/www/prueba1/index.html
git clone  git@github.com:roxsross/bootcamp-devops-2023.git
