FROM phusion/passenger-jruby91
LABEL maintainer="kj.garza@gmail.com"


# Provide a non-root user to run the process.
RUN groupadd --gid 1000 logstash 
RUN adduser --uid 1000 --gid 1000 \
      --home /usr/share/logstash --no-create-home \
      logstash

# Update installed APT packages, clean up when done
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install ntp wget -y && \
    apt-get install -y sudo && \
    apt-get install -y golang-go && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add Logstash itself.
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
RUN sudo apt-get install apt-transport-https
RUN echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
RUN sudo apt-get update && sudo apt-get install logstash



# RUN curl -Lo - {{ url_root }}/{{ tarball }} | \
#     tar zxf - -C /usr/share && \
#     mv /usr/share/logstash-{{ elastic_version }} /usr/share/logstash && \
#     chown --recursive logstash:logstash /usr/share/logstash/ && \
#     chown -R logstash:root /usr/share/logstash && \
#     chmod -R g=u /usr/share/logstash && \
#     find /usr/share/logstash -type d -exec chmod g+s {} \; && \
#     ln -s /usr/share/logstash /opt/logstash

WORKDIR /usr/share/logstash

ENV ELASTIC_CONTAINER true
ENV PATH=/usr/share/logstash/bin:$PATH


# Provide a minimal configuration, so that simple invocations will provide
# a good experience.
COPY . /usr/share/logstash

# ADD config/pipelines.yml config/pipelines.yml
# ADD config/logstash-{{ image_flavor }}.yml config/logstash.yml
# ADD config/log4j2.properties config/
# ADD pipeline/default.conf pipeline/logstash.conf
RUN chown --recursive logstash:root config/ pipeline/

# Ensure Logstash gets a UTF-8 locale by default.
ENV LANG='en_US.UTF-8' LC_ALL='en_US.UTF-8'

# Place the startup wrapper script.
COPY vendor/docker/docker-entrypoint /usr/local/bin/
RUN chmod 0755 /usr/local/bin/docker-entrypoint

# USER logstash

COPY vendor/docker/env2yaml.go /usr/local/bin/
RUN sudo chmod a+x /usr/local/bin/env2yaml.go
RUN sudo chmod a+w /usr/share/logstash/Gemfile.lock

ENV JAVA_HOME "/usr"


# RUN gem update --system && \
#     gem install bundler 
RUN gem install rake && \
    cp logstash-core/versions-gem-copy.yml logstash-core-plugin-api/  && \
    /sbin/setuser logstash bundle install --path vendor/bundle
    # gem install logstash-core-plugin-api 
RUN cp logstash-core/versions-gem-copy.yml logstash-core-plugin-api/ 
    # /sbin/setuser logstash bundle install --path vendor/bundle

USER logstash


EXPOSE 9600 5044

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

# CMD ["sudo", "systemctl", "start", "logstash.service"]



# WORKDIR /usr/share/logstash
# ### Remove default configuration
# RUN rm -f /usr/share/logstash/pipeline/logstash.conf && \
#     rm -f /usr/share/logstash/config/logstash.yml

# RUN ./bin/logstash-plugin install logstash-filter-rest && \
#     ./bin/logstash-plugin install logstash-filter-prune && \
#     ./bin/logstash-plugin install --development

# # COPY pipeline/*.conf .pipeline/
# # COPY config/ /usr/share/logstash/config/

# # RUN mkdir patterns && \
# #     mkdir plugins && \
# #     mkdir spec && \
# #     cp logstash-core/versions-gem-copy.yml logstash-core-plugin-api/

# COPY . /usr/share/logstash

# RUN cp logstash-core/versions-gem-copy.yml logstash-core-plugin-api/

# # COPY patterns/ ./patterns/
# # COPY data/ ./data/
# # COPY plugins/ ./plugins/ 
# # COPY spec/ ./spec/

# RUN chmod -R 755 /usr/share/logstash && \
#     ruby -S gem update --system 

# CMD ["logstash", "-f", "/usr/share/logstash/pipeline"]


