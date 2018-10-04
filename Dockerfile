FROM docker.elastic.co/logstash/logstash:6.4.0
LABEL maintainer="kj.garza@gmail.com"


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

RUN cp vendor/docker/Gemfile /usr/share/logstash/Gemfile
RUN ./bin/logstash-plugin install --no-verify