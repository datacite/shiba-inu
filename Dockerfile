FROM docker.elastic.co/logstash/logstash:6.4.0
LABEL maintainer="kgarza@datacite.org"


WORKDIR /usr/share/logstash
ENV ELASTIC_CONTAINER true
ENV PATH=/usr/share/logstash/bin:$PATH


### Remove default configuration
RUN rm -f /usr/share/logstash/pipeline/logstash.conf && \
    rm -f /usr/share/logstash/config/logstash.yml


# Ensure Logstash gets a UTF-8 locale by default.
ENV LANG='en_US.UTF-8' LC_ALL='en_US.UTF-8'


RUN ./bin/logstash-plugin install logstash-filter-rest && \
    ./bin/logstash-plugin install logstash-filter-prune && \
    ./bin/logstash-plugin install --development

# Provide a minimal configuration, so that simple invocations will provide
# a good experience.
COPY . /usr/share/logstash


RUN cp logstash-core/versions-gem-copy.yml logstash-core-plugin-api/ && \
    export PATH=$PATH:/usr/share/logstash/vendor/bundle/jruby/2.3.0/bin

COPY --chown=logstash vendor/docker/Gemfile /usr/share/logstash/Gemfile
RUN ./bin/logstash-plugin install --no-verify

ENV ES_HOST elasticsearch:9200
ENV ES_INDEX resolutions
ENV INPUT_DIR /usr/share/logstash/tmp/datacite_logs_201805/DataCite-access.log-201805
ENV OUTPUT_DIR /usr/share/logstash/tmp/output.json
