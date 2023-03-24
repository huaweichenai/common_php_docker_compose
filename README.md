# 通用PHP项目Docker开发环境(compose版本)
---
该项目为通用PHP系统在本地以Compose方式部署开发环境所使用的模板

## 准备工作
### 1. 编辑`.env-dist`(非必须)
如果本地使用了多套该compose运行环境，则必须调整各自目录下该文件的`COMPOSE_PROJECT_NAME`参数值，以确保相互间唯一

### 2. 创建`docker-compose.yml`
#### 2.1 从模板文件复制生成`docker-compose.yml`
```bash
cp docker-compose.yml.template docker-compose.yml
```
#### 2.2 内容调整
替换以下内容
- [本机项目路径]
- [项目编号_项目简拼]

> 注：若本地使用了多套该compose运行环境，且会同时启动运行，则需调整`ports`映射，以确保相互间端口不出现冲突的情况，例如：
```
# Mysql容器
    mysql:
        ...
        ports:
            # 这里左侧为映射到外部的可访问的端口，可视情况调整为其他值，确保端口不冲突
            - "33066:3306"
        ...
```

> 如若需要变更Mysql数据库root账号的访问密码，则按以下说明调整：
```
# Mysql容器
    mysql:
        ...
        environment:
            # 3330333为默认root密码，可调整为其他值（必填）
            MYSQL_ROOT_PASSWORD: 3330333
```

### 3. 建立nginx配置文件
按照一个项目对应一个配置文件的原则，以`nginx/demo.conf.template`文件为模板，在`nginx/`目录下建立实际项目使用的配置文件，文件名称格式为：`[项目编号_项目简拼].conf`，并替换以下内容：
- [项目编号]
- [项目名称]
- [各应用域名]
- [项目编号_项目简拼]
> 如果某个项目需要额外多个应用访问配置，则可直接复制模板文件内已有应用的配置代码，并在替换上述内容外，额外注意调整访问log日志的文件名称

### 4. 配置php容器内的定时任务(非必须)
编辑`php/crontabs/www-data`，参照文件内给的实例，编写实际项目中所使用的定时任务

### 5. 配置php容器内的进程维护服务(非必须)
如果项目内需要使用队列任务、websocket服务等需要一直运行的进程服务时，参照`php/supervisor/conf.d/demo-queue.conf.template`文件为模板，在`php/supervisor/conf.d/`目录下建立进程管理配置文件，且一个进程对应一个配置文件，文件名称格式为：`[项目编号_项目简拼]-[进程名].conf`，并替换以下内容：
- [项目编号_项目简拼]

再根据进程所对应的脚本执行方式，视情况调整以下参数配置：
- command：脚本执行方式
- autorestart：是否需要自动重启
- numprocs：开启的进行数量，队列类型可视情况增加数量，对于websocket服务，一般设置为1
- stdout_logfile：进程脚本执行时的输出内容存储文件

### 6. php容器内安装软件或服务、扩展(非必须)
若需要在php容器内安装其他软件或服务、php扩展等，可在`php/Dockerfile`内指定注释说明的下方增加构建步骤的编写，构建方式参照Dockerfile官方语法

---
## Build
`make build`

## Start
`make start`

## Stop
`make stop`

## Status
`make status`

## Down
`make down`

## Containers
### 进入容器
#### Nginx
`docker exec -it [NGINX_CONTAINER] sh`

#### PHP
`docker exec -it [PHP_CONTAINER] bash`

#### PHP CLI
`make php-cli`

#### Mysql
`docker exec -it [MYSQL_CONTAINER] bash`

> 该compose模板支持不同需求下开发环境的扩展，但仅限于在本地进行软件开发测试场景使用，不推荐在实际的生产环境下部署使用
