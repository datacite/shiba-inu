# Pipeline for DOI Resolution Logs processing

[![Build Status](https://travis-ci.org/datacite/shiba-inu.svg?branch=master)](https://travis-ci.org/datacite/shiba-inu) 
[![Docker Build Status](https://img.shields.io/docker/build/datacite/shiba-inu.svg)]
[![Test Coverage](https://api.codeclimate.com/v1/badges/107d556dafb28c85d261/test_coverage)](https://codeclimate.com/github/datacite/shiba-inu/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/107d556dafb28c85d261/maintainability)](https://codeclimate.com/github/datacite/shiba-inu/maintainability)

Shiba-Inu is pipeline for DOI Resolution Logs processing. The pipeline processes DOI resolution logs following the [Code of practice for research data usage metrics](https://doi.org/10.7287/peerj.preprints.26505v1). Its based in Logstash.


![The Shiba Inu is the smallest of the six original and distinct spitz breeds of dog from Japan.](https://i.imgur.com/ueW0Leo.jpg)


## Installation

Requirements

- A Elasticsearch instance
- Single line logs with DOI names.


One can run the logs processor using Docker. you will need to set the following enviroment variables:

```
ES_HOST=http://elasticsearch:9200
ES_INDEX=resolutions
INPUT_DIR=/usr/share/logstash/tmp/DataCite-access.log-201805
OUTPUT_DIR=/usr/share/logstash/tmp/output.json
LOGSTASH_HOST = localhost:9600

S3_MERGED_LOGS_BUCKET     = /usr/share/logstash/monthly_logs
S3_RESOLUTION_LOGS_BUCKET = /usr/share/logstash/
ELASTIC_PASSWORD=changeme
LOGS_TAG=[Resolution Logs]

HUB_TOKEN=eyJhbGciOiJSUzI1NiJ9
HUB_URL=https://api.test.datacite.org
```


and run the container like this:

```
docker run -p 8090:9200 datacite/shiba-inu
```

Alternatively you can use docker-compose to use the log processor without an elasticsearch instace:


```
docker-compose up
```

## Usage logs

Your logs need to fulling a 2 of requerimentes:

- The logs must be single line logs.
- MUST include the following data:
  - doi => DOI name
  - occurred_at => timestamp (ISO8601)
  - clientip => IP address (IPV4 or IPV6)
  - user_agent => user agent


You will need to provide the configuration of your log lines following the grok filter documentation. You can enter the configuration in the file `/vendor/docker/log_configuration.tmpl`. 

For example for logs file with the following style:

```text
46.229.168.146 HTTP:HDL "2018-09-30 23:40:39.132Z" 1 1 3ms 10.5277/ppmp1850 "300:10.admin/codata" "" "Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.8) Gecko/20051111 Firefox/1.5"
131.180.162.29 HTTP:HDL "2018-09-30 23:40:42.731Z" 1 1 71ms 10.4233/uuid:9798fb4a-9201-4efa-b324-3e50bbdc7ca5 "300:10.admin/codata" "" ""
131.180.162.29 HTTP:HDL "2018-09-30 23:40:44.846Z" 1 100 111ms 10.4233/uuid:a92fc858-da92-4339-8f80-b608aaa09741 "" "" ""

```
One would need the following configuration:

```logstash

"^%{IP:clientip} (?<handle>(HTTP:HDL)) %{QS:occurred_at} %{INT:ld} %{INT:resp_code} (?<ms>((.+ms))) %{DOI:doi} %{QS:server} %{QS:something} %{QS:user_agent}"

```

## How to create reports

There are 3 basics steps to create a report.

1. Copy your usage logs to `/usage_logs`
2. Trigger the logs processing.
3. Generate the report.


### 1. Copying the usage logs

The logs processor is restricted to processes logs in a monthly basis and with individual files or ordered files. You would need to merge all your logs in a single file or rename them in order. Logs files must be places in `/usage_logs`.


### 2. Trigger the logs processing

The logs processor will start working automatically once a new logs get to the logs folder.

### 3. Generate the report.

Usage reports can be generated locally, pushed and/or streamed to the MDC Hub. We can use the `kishu` client for logs processing to generate a report in any of these ways. To run the `kishu` client you need to be inside the logstash docker container. The kishu client does not need paramaters about the report that need be generate (i.e. month) as automatically will generate the report with whatever is in the logs processor pipeline.


```shell 
source /usr/local/rvm/scripts/rvm
rvm use 2.4.1
```

To generate a usage report in JSON format following the Code of Practice for Usage Metrics, you can use the following command. This will generate a usage report in the folder `/reports`.



```shell
bundle exec kishu sushi generate_report created_by:{YOUR DATACITE CLIENT ID}
```

To generate and push a usage report in JSON format following the Code of Practice for Usage Metrics, you can use the following command. 

```shell
bundle exec kishu sushi push_report created_by:{YOUR DATACITE CLIENT ID}
```

To stream a usage report in JSON format following the Code of Practice for Usage Metrics, you can use the following command. This option should be only used with reports with more than 50,000 datasets or larger than 10MB. We compress all reports that are streammed to the the MDC Hub.

```shell
bundle exec kishu sushi stream_report created_by:{YOUR DATACITE CLIENT ID}
```

Further information about parametrizing the streaming can be found in the [kishu](https://github.com/datacite/kishu) client.


## Development

We use Rspec for unit and acceptance testing:

```
ruby -S bundle exec rspec
```

Follow along via [Github Issues](https://github.com/datacite/shiba-inu/issues).

### Note on Patches/Pull Requests

* Fork the project
* Write tests for your new feature or a test that reproduces a bug
* Implement your feature or make a bug fix
* Do not mess with Rakefile, version or history
* Commit, push and make a pull request. Bonus points for topical branches.

## License
**shiba-inu** is released under the [MIT License](https://github.com/datacite/shiba-inu/blob/master/LICENSE).
