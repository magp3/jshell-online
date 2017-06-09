FROM node:latest
#MAINTAINER Nathan LeClaire <nathan@docker.com>

ADD . /app
WORKDIR /app
RUN npm install

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | \
   debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | \
   debconf-set-selections
RUN apt-get install -y oracle-java9-installer
# RUN apt-get update
# RUN apt-get install -y software-properties-common python-software-properties
# RUN add-apt-repository -y ppa:webupd8team/java
# RUN apt-get update
# RUN apt-get install -y oracle-java9-installer

EXPOSE 3000

ENTRYPOINT ["node"]
CMD ["app.js", "-p", "3000"]
