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
COPY --chown=logstash . /usr/share/logstash
# COPY --chown=logstash /usr/share/logstash/app /usr/share/logstash/plugins/shiba-inu

RUN ./bin/logstash-plugin install logstash-output-amazon_es 

RUN cp logstash-core/versions-gem-copy.yml logstash-core-plugin-api/ && \
    export PATH=$PATH:/usr/share/logstash/vendor/bundle/jruby/2.3.0/bin

COPY --chown=logstash vendor/docker/Gemfile /usr/share/logstash/Gemfile
RUN ./bin/logstash-plugin install --no-verify


ENV INPUT_DIR /usr/share/logstash/tmp/datacite_logs_201805/DataCite-access.log-201805
ENV OUTPUT_DIR /usr/share/logstash/tmp/output.json
ENV ES_INDEX resolutions
ENV ES_HOST elasticsearch:9200

USER root
RUN yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby="ruby-2.4.1 jruby-9.1.13.0"
SHELL [ "/bin/bash", "-l", "-c" ]
RUN source /usr/local/rvm/scripts/rvm
RUN rvm use ruby-2.4.1
RUN git clone https://github.com/kjgarza/kishu && \
    cd kishu && \
    gem build kishu.gemspec && \
    gem install kishu-0.1.1.gem 
USER logstash