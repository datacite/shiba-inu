FROM docker.elastic.co/logstash/logstash:6.2.4
LABEL maintainer="kgarza@datacite.org"


WORKDIR /usr/share/logstash
### Remove default configuration
RUN rm -f /usr/share/logstash/pipeline/logstash.conf
RUN rm -f /usr/share/logstash/config/logstash.yml

RUN ./bin/logstash-plugin install logstash-filter-rest

COPY logstash/pipeline/ /usr/share/logstash/pipeline/
COPY logstash/config/ /usr/share/logstash/config/

RUN mkdir patterns
COPY logstash/patterns ./patterns

RUN mkdir plugins
COPY logstash/plugins ./plugins


