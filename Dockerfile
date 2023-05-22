FROM centos:7
RUN yum -y install java-1.8.0-openjdk-devel curl
RUN curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-linux-x86_64.tar.gz
RUN useradd -ms /bin/bash elasticsearch

RUN tar -xvf elasticsearch-7.10.2-linux-x86_64.tar.gz
cd elasticsearch-7.10.2/bin
./elasticsearch \
CMD
EXPOSE 9200