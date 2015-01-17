# docker-idoit-open
A idoit-open docker container

docker build -t "mazienho/idoit-open" .

docker run -d -p 10080:80 -p 10022:22 --name="idoit" mazienho/idoit-open

Standard passwords:

ssh: root/root
mysql: root/secret
idoit admin center: admin/admin