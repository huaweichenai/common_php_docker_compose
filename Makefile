build:
	cp .env-dist .env
	docker-compose build --force-rm
	docker-compose up -d

start:
	docker-compose start

status:
	docker-compose ps

stop:
	docker-compose stop

php-cli:
	docker-compose run --rm -u www-data --entrypoint='' php bash

log-clear:
	rm -f ./opt/log/nginx/*.log

down:
	docker-compose down --rmi local
	rm .env

ports:
	@echo 'xx系统: 前台[www.xxxx] 后台[admin.xxxx] API[api.xxxx]'
