FROM debian:latest
MAINTAINER Mazienho <mazienho@gmx.de>

#Add required files
ADD src/ /idoit-src

USER root

#Run the install-script
RUN /idoit-src/install-idoit.sh

#Open ssh and http port
EXPOSE 22 80

CMD /run.sh