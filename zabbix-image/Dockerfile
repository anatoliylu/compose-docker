FROM ubuntu:22.04

# Обновлення та установка необхідних пакетів
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget gnupg2

# Установка репозиторія Zabbix
RUN wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu22.04_all.deb && \
    dpkg -i zabbix-release_6.4-1+ubuntu22.04_all.deb && \
    apt-get update

# Установка MySQL сервера та необхідних залежностей
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server mysql-client

# Запуск сервісу MySQL та створення бази даних
RUN service mysql start && mysql -uroot -e "CREATE DATABASE zabbix character set utf8 collate utf8_bin;"

# Створення користувача та надання привілеїв для бази даних Zabbix
RUN service mysql start && mysql -uroot -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'password';"
RUN service mysql start && mysql -uroot -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost' WITH GRANT OPTION;"

# Установка Apache, PHP та залежностей
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y apache2 php libapache2-mod-php php-mysql php-xml

# Установка компонентів Zabbix
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf

# Копіювання конфігураційних файлів
COPY zabbix_server.conf /etc/zabbix/zabbix_server.conf
COPY apache.conf /etc/zabbix/apache.conf

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]



