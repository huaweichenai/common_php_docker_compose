#!/bin/sh
set -e

# 启动定时任务服务
echo '[i] Starting cron ...'
# 定时任务所需环境变量
eval $(printenv | awk -F= '{print "export " "\""$1"\"""=""\""$2"\"" }' > /etc/cron.env)
service cron start

# 启动Supervisor服务
service supervisor start

if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

exec "$@"
