FROM drupal:8-apache

# Install packages
RUN rm /bin/sh && ln -s /bin/bash /bin/sh && \
    apt-get update && apt-get install --no-install-recommends -y \
    curl \
    wget \
    vim \
    git \
    unzip \
    mysql-client

# Install PHP extensions
# RUN docker-php-ext-install \
#     mcrypt

# Clean repository
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#---------------------- Install development tools ----------------------

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

#  Install Drush
RUN composer global require drush/drush && \
    composer global update

# Install Drupal Console Launcher
RUN curl https://drupalconsole.com/installer -L -o drupal.phar && \
    mv drupal.phar /usr/local/bin/drupal && \
    chmod +x /usr/local/bin/drupal

# Install Drupal Console
RUN cd /var/www/html && \
    composer require drupal/console:~1.0 --prefer-dist --optimize-autoloader && \
    drupal init

# Copy sites
COPY sites /var/www/html/sites/

# Copy custom php.ini
COPY php.ini /usr/local/etc/php/php.ini

# Create the private files directory and make files dir writeable
RUN mkdir /var/private_files && \
    chown -R www-data:www-data /var/www/html && \
    chown -R www-data:www-data /var/private_files && \
    chown -R www-data:www-data /tmp && \
    touch /var/log/php-errors.log && \
    chown www-data:www-data /var/log/php-errors.log

#COPY environment.env /var/environment.env

# Setup exim4 for transactional emails. Simple setup
RUN apt-get update && \
  apt-get install -y exim4 &&\
  echo 'sendmail_path = "/usr/sbin/exim4 -t"' >> /usr/local/etc/php/conf.d/mail.ini && \
  echo 'SMTP = localhost' >> /usr/local/etc/php/conf.d/mail.ini && \
  echo 'smtp_port = 25' >> /usr/local/etc/php/conf.d/mail.ini
COPY ./exim4.conf /etc/exim4/exim4.conf
RUN chmod 644 /etc/exim4/exim4.conf

# composer global config minimum-stability dev && \
# composer global config prefer-stable true && \
