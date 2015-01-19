# docker-idoit-open
A idoit-open docker container

### Commands

docker build -t "mazienho/idoit-open" .

docker run -d -p 10080:80 -p 10022:22 --name="idoit" mazienho/idoit-open

### Standard login credentials:

_If you want to change them, look into the install script_

ssh: root/root

mysql: root/secret

idoit admin center: admin/admin
