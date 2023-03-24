FROM php:local-7

# 若需要安装其他软件或服务、扩展，请在该注释下进行构建步骤的编写


# 加载Supervisor配置文件
RUN mkdir -p /etc/supervisor/conf.d
COPY ./supervisor/supervisord.conf /etc/supervisord.conf
COPY ./supervisor/conf.d/ /etc/supervisor/conf.d/

# 加载定时任务配置文件
COPY ./crontabs/www-data /var/spool/cron/crontabs/www-data
RUN chmod 600 /var/spool/cron/crontabs/www-data

# (Debian only) Change www-data user ID
# ENV PHP_USER_ID 1000
# RUN set -x \
#     && userdel www-data \
#     && groupadd -g ${PHP_USER_ID} -r www-data \
#     && useradd -u ${PHP_USER_ID} -r -g www-data www-data

# 默认入口命令
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

WORKDIR /opt/htdocs

EXPOSE 9000
CMD ["php-fpm"]
