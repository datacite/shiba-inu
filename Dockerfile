FROM docker.elastic.co/logstash/logstash:6.2.4
LABEL maintainer="kj.garza@gmail.com"


WORKDIR /usr/share/logstash
### Remove default configuration
RUN rm -f /usr/share/logstash/pipeline/logstash.conf && \
    rm -f /usr/share/logstash/config/logstash.yml

RUN ./bin/logstash-plugin install logstash-filter-rest && \
    ./bin/logstash-plugin install --development

COPY logstash/pipeline/*.conf .pipeline/
COPY logstash/config/ /usr/share/logstash/config/

RUN mkdir patterns && \
    mkdir plugins && \
    mkdir spec

COPY logstash/patterns/ ./patterns/
COPY logstash/plugins/ ./plugins/ 
COPY spec/ ./spec/

CMD ["logstash", "-f", "/usr/share/logstash/pipeline"]


