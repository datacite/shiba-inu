dockerize -template vendor/docker/02_input_file.tmpl:/usr/share/logstash/pipeline/main/02_input_file.conf
dockerize -template vendor/docker/30_output_elasticsearch.tmpl:/usr/share/logstash/pipeline/main/30_output_elasticsearch.conf
#dockerize -template vendor/docker/03_filter_grok.tmpl:/usr/share/logstash/pipeline/main/03_filter_grok.conf
