FROM centos:centos7
LABEL maintainer "Will Simpson <wsimpson@email.arizona.edu>"

# Install Inline with Upstream Stable (IUS), which also enables EPEL.
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm

# Install Python and Supervisor.
RUN yum -y install python-setuptools
RUN mkdir -p /var/log/supervisor
RUN easy_install supervisor

# Install Entrada Developer dependancies.
RUN yum -y install git \
                htmldoc \
                wkhtmltopdf \
                curl \
                wget \
                unzip \
                iproute \
                hostname \
                inotify-tools \
                yum-utils \
                which \
                ruby \
                rubygems \
                exim \
                openssl \
                httpd \
                mod_ssl \
                php56u \
                php56u-mcrypt \
                php56u-gd \
                php56u-devel \
                php56u-mysql \
                php56u-intl \
                php56u-mbstring \
                php56u-pecl-xdebug \
                php56u-bcmath \
                php56u-ldap \
                php56u-imap \
                php56u-pspell \
                php56u-soap \
                php56u-xmlrpc \
                php56u-tidy \
                php56u-opcache

RUN curl -sSL https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Update PHP's configuration
RUN sed -i 's@;date.timezone =@date.timezone = '"$TZ"'@g' /etc/php.ini
RUN sed -i 's@display_errors = Off@display_errors = On@g' /etc/php.ini
RUN sed -i 's@error_reporting = E_ALL \& ~E_DEPRECATED \& ~E_STRICT@error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED@g' /etc/php.ini
RUN sed -i 's@upload_max_filesize = 2M@upload_max_filesize = 512M@g' /etc/php.ini
RUN sed -i 's@post_max_size = 8M@post_max_size = 512M@g' /etc/php.ini
RUN sed -i 's@memory_limit = 128M@memory_limit = 512M@g' /etc/php.ini

# Install Capistrano for deployment recipes.
RUN gem install capistrano -v 2.15.9
RUN gem install colorize
RUN gem install sshkit
RUN gem install gnm-caplock

# Tell Apache to include all of the virtual hosts
RUN echo "IncludeOptional vhosts.d/*.conf" >> /etc/httpd/conf/httpd.conf

# Copy Supervisor configuration.
COPY supervisor/supervisord.conf /etc/supervisord.conf

RUN usermod -u 1000 apache 
RUN groupmod -g 1000 apache 

RUN chown -R apache:apache /var/lib/php

CMD ["/usr/bin/supervisord"]
