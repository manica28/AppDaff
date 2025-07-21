# Image de base
FROM php:8.3-fpm

# Installer les extensions nécessaires
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo pdo_pgsql pgsql zip \
    && rm -rf /var/lib/apt/lists/*

# Installer Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Définir le dossier de travail
WORKDIR /app

# Copier le code de l'hôte vers le conteneur
COPY . .

# Définir les permissions (optionnel)
RUN chown -R www-data:www-data /app && chmod -R 755 /app

# Exposer le port FPM
EXPOSE 9000

# Lancer php-fpm en entrée
CMD ["php-fpm"]
