FROM docker.elastic.co/logstash/logstash:6.2.4
LABEL maintainer="kj.garza@gmail.com"


WORKDIR /usr/share/logstash
### Remove default configuration
RUN rm -f /usr/share/logstash/pipeline/logstash.conf && \
    rm -f /usr/share/logstash/config/logstash.yml

RUN ./bin/logstash-plugin install logstash-filter-rest && \
    ./bin/logstash-plugin install logstash-filter-prune && \
    ./bin/logstash-plugin install --development

# COPY pipeline/*.conf .pipeline/
# COPY config/ /usr/share/logstash/config/

# RUN mkdir patterns && \
#     mkdir plugins && \
#     mkdir spec && \
#     cp logstash-core/versions-gem-copy.yml logstash-core-plugin-api/

COPY . /usr/share/logstash

RUN cp logstash-core/versions-gem-copy.yml logstash-core-plugin-api/

# COPY patterns/ ./patterns/
# COPY data/ ./data/
# COPY plugins/ ./plugins/ 
# COPY spec/ ./spec/

RUN chmod -R 755 /usr/share/logstash && \
    ruby -S gem update --system 

CMD ["logstash", "-f", "/usr/share/logstash/pipeline"]


