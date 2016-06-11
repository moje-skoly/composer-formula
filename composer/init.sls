get-composer:
  cmd.run:
    - name: 'CURL=`which curl`; $CURL -sS https://getcomposer.org/installer | php'
    - unless: test -f /usr/bin/composer
    - cwd: /root/

install-composer:
  cmd.wait:
    - name: mv /root/composer.phar /usr/bin/composer
    - cwd: /root/
    - watch:
      - cmd: get-composer

composer:
  file.exists:
  - name: /usr/bin/composer
  - require:
    - cmd: install-composer

composer-dir:
  file.directory:
    - name: /var/www/.composer
    - user: www-data
    - group: www-data
    - required_in:
      - file: composer
