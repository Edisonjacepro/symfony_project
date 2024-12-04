# Utilisation de l'image PHP avec FPM
FROM php:8.2-fpm

# Installation des dépendances nécessaires pour Symfony
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    git \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql

# Installation de Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copie de l'application dans le conteneur
WORKDIR /var/www/html
COPY . /var/www/html

# Installation des dépendances de Symfony
RUN composer install

# Exposer le port 9000 pour PHP-FPM
EXPOSE 9000

RUN apt-get update && apt-get install -y git \
    && git config --global user.name "Edisonjacepro" \
    && git config --global user.email "edison.jace.pro@gmail.com"
