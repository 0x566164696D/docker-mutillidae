# OWASP Mutillidae II with NGINX  
Forked from  https://github.com/edoz90/docker-mutillidae

## Differences
    - latest mutillidae release
    - nginx\mariadb\php-fpm performance tweaks
    - doesn't fail on heavy load
    - PhpMyAdmin fixed
    - added logs for nginx\mariadb\php-fp
    - GMT +3 timezone 
    - you may change default security level. See Dockerfile.

## Steps
```
docker build . --force-rm -t nginx_mutillidae
docker run -d -p 8081:80 --rm --name nginx_mutillidae nginx_mutillidae
```

## Get Image from docker hub

```
docker run -d -p 8081:80 --rm --name nginx_mutillidae 0x566164696d/nginx_mutillidae
```

## MySQL
During the build of the container MySQL passwords will be randomly generated and printed on console:

```
[!!!] MySQL 'root' password is: FJVHs4vwVCTo94A
[!!!] MySQL 'mutillidae' password is: pzborshCWPpKLy9
```

## TODO
    - Fix ldap injection


