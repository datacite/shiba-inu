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

# define working directory
WORKDIR /usr/share/logstash
ENV ELASTIC_CONTAINER true
ENV PATH=/usr/share/logstash/bin:$PATH

# Provide a minimal configuration, so that simple invocations will provide
# a good experience.
COPY . /usr/share/logstash
RUN chown --recursive logstash:root config/ pipeline/

# Ensure Logstash gets a UTF-8 locale by default.
ENV LANG='en_US.UTF-8' LC_ALL='en_US.UTF-8'

# Place the startup wrapper script.
COPY vendor/docker/docker-entrypoint /usr/local/bin/
RUN chmod 0755 /usr/local/bin/docker-entrypoint

# Copy other files and change permissions
COPY vendor/docker/env2yaml.go /usr/local/bin/
RUN sudo chmod a+x /usr/local/bin/env2yaml.go
RUN sudo chmod a+w /usr/share/logstash/Gemfile.lock
RUN sudo chmod a+w /usr/share/logstash/Gemfile

# define the Java home
ENV JAVA_HOME "/usr"


RUN gem install rake && \
    gem install logstash-core-plugin-api && \
    cp logstash-core/versions-gem-copy.yml logstash-core-plugin-api/  && \
    /sbin/setuser logstash bundle install --path vendor/bundle
# RUN cp logstash-core/versions-gem-copy.yml logstash-core-plugin-api/ 
RUN ./bin/logstash-plugin install --development

USER logstash

EXPOSE 9600 5044

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]



