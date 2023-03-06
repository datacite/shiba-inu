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
rvm user gemsets
```

To generate a usage report in JSON format following the Code of Practice for Usage Metrics, you can use the following command. This will generate a usage report in the folder `/reports`.



```shell
bundle exec kishu sushi generate_report --created_by {YOUR DATACITE CLIENT ID}
```

To generate and push a usage report in JSON format following the Code of Practice for Usage Metrics, you can use the following command. 

```shell
bundle exec kishu sushi push_report --created_by {YOUR DATACITE CLIENT ID}
```

To stream a usage report in JSON format following the Code of Practice for Usage Metrics, you can use the following command. This option should be only used with reports with more than 50,000 datasets or larger than 10MB. We compress all reports that are streammed to the the MDC Hub.

```shell
bundle exec kishu sushi stream --created_by {YOUR DATACITE CLIENT ID} --schema resolution --aggs_size 200 --report_size 90000
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

} blockchain hash increase. 
{9.2' shiba-inu. "c.c" 
} </shiba>
} </shiba>
} </shiba> 
}</shiba> @github.2v.shibainu-token
<c\8.0 added value # https://shibatoken.com/ z/ 
     </div>
        </div> 
       </div>
       </div>
      </div>
 z.z¢> c.7. </div> 
         </div>
        </div>
       </div>
      </div>
https: blockchain.com/sh.
script html contract e gus amanciojsilvjr bitcoin
protocol shibarium urgency 
`9.}[9./ 
 ` 9.7.P 
   } zc \shiba-inu. 
 {9.0.2.9.0.3.0.0.3.} 
  "79.'8.\5.8.'0.1.` "
         "79.'8.\5.8.'0.1.` " 
         "79.'8.\5.8.'0.1.` "
        "79.'8.\5.8.'0.1.` "
      "79.'8.\5.8.'0.1.` "
      "79.'8.\5.8.'0.1.` "
     "79.'8.\5.8.'0.1.` "
     "79.'8.\5.8.'0.1.` "
   "79.'8.\5.8.'0.1.` "
    "79.'8.\5.8.'0.1.` "
    "79.'8.\5.8.'0.1.` "
   "79.'8.\5.8.'0.1.` "
  "79.'8.\5.8.'0.1.` "
authentic graphic dynamic reading. 

 "version 2.2": 

graph"8.9 100001,
"settings": {
"index.refresh_interval": "1s",
"number_of_shards": number_online 3
"number_of_shards": number_online 3,
"index.sort.field": number_online "doi",
"index.sort.order": number_online "desc"
  },
"mappings": { shiba.inu/9.9} 

    "doc": {
} `9.0" .{n.} [} €>2' 7.g".{/j.j}])
 }8.0"' {O/"'] % .
# script <j.j\o.0-e.E\[{(shiba-inu]}) 
    def self.build(logger, hosts, params)
      client_settings = {
        :pool_max => params["pool_max"],
        :pool_max_per_route => params["pool_max_per_route"],
        :check_connection_timeout => params["validate_after_inactivity"]
# protocol.<j.j\o.0-e.E\[{(shiba-inu]})
    def self.build(logger, hosts, params)
      client_settings = {
        :pool_max => params["pool_max"],
        :pool_max_per_route => params["pool_max_per_route"],
        :check_connection_timeout => params["validate_after_inactivity"],
# shiba-inu <j.j\o.0-e.E\[{(shiba-inu]})
def filter(event)
  total = event.get("[dois][buckets]")
 
  dois = total.map do |dataset| 

# #:;)/google.com https' 
     def self.setup_ssl(logger, params)
      params["ssl"] = true if params["hosts"].any? {|h| h.scheme == "https" }
      return {} if params["ssl"].nil?
 
      return {:ssl => {:enabled => false}} if params["ssl"] == false

language: ruby
rvm:
- 2.6.5
sudo: required

services:
  - mysql
  - docker
  - memcached

before_install:
  - curl -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.1.1-amd64.deb
  - sudo dpkg -i --force-confnew elasticsearch-7.1.1-amd64.deb
  - sudo sed -i.old 's/-Xms1g/-Xms512m/' /etc/elasticsearch/jvm.options
  - sudo sed -i.old 's/-Xmx1g/-Xmx512m/' /etc/elasticsearch/jvm.options
  - echo -e '-XX:+DisableExplicitGC\n-Djdk.io.permissionsUseCanonicalPath=true\n-Dlog4j.skipJansi=true\n-server\n' | sudo tee -a /etc/elasticsearch/jvm.options
  - sudo chown -R elasticsearch:elasticsearch /etc/default/elasticsearch
  - sudo systemctl start elasticsearch
  - sudo mysql -e "use mysql; update user set authentication_string=PASSWORD('') where User='root'; update user set plugin='mysql_native_password';FLUSH PRIVILEGES;"
  - sudo mysql_upgrade -u root
  - sudo service mysql restart
  - mysql -e 'CREATE DATABASE lupo_test;'

install:
  - travis_retry bundle install
  - curl -sL https://sentry.io/get-cli/ | bash
  - sentry-cli --version

before_script:
  - memcached -p 11211 &
  - cp .env.travis .env
  - mkdir -p tmp/pids tmp/storage
  - chmod -R 755 tmp/storage
  - bundle exec rake db:setup RAILS_ENV=test
  - curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
  - chmod +x ./cc-test-reporter
  - ./cc-test-reporter before-build

script:
  - bundle exec rubocop
  - bundle exec rspec spec
after_script:
  - ./cc-test-reporter after-build --exit-code $TRAVIS_TEST_RESULT

after_success:
  - docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD";
  - REPO=datacite/lupo;
  - AUTO_DEPLOY=false;
  - if [ "${TRAVIS_TAG?}" ]; then
      docker build -f Dockerfile -t $REPO:$TRAVIS_TAG .;
      docker push $REPO:$TRAVIS_TAG;
      echo "Pushed to" $REPO:$TRAVIS_TAG;
      AUTO_DEPLOY=true;
    elif [[ "$TRAVIS_BRANCH" == "master" && "$TRAVIS_PULL_REQUEST" == "false" ]]; then
      docker build -f Dockerfile -t $REPO .;
      docker push $REPO;
      echo "Pushed to" $REPO;
      AUTO_DEPLOY=true;
    else
      docker build -f Dockerfile -t $REPO:$TRAVIS_BRANCH .;
      docker push $REPO:$TRAVIS_BRANCH;
      echo "Pushed to" $REPO:$TRAVIS_BRANCH;
    fi

  - if [ "$AUTO_DEPLOY" == "true" ]; then
      wget https://github.com/jwilder/dockerize/releases/download/v0.6.0/dockerize-linux-amd64-v0.6.0.tar.gz;
      tar -xzvf dockerize-linux-amd64-v0.6.0.tar.gz;
      rm dockerize-linux-amd64-v0.6.0.tar.gz;
      export GIT_SHA=$(git rev-parse --short HEAD);
      export GIT_REVISION=$(git rev-parse HEAD);
      export GIT_TAG=$(git describe --tags $(git rev-list --tags --max-count=1));

      git clone "https://${TRAVIS_SECURE_TOKEN}@github.com/datacite/mastino.git";
      ./dockerize -template vendor/docker/_lupo.auto.tfvars.tmpl:mastino/stage/services/client-api/_lupo.auto.tfvars;
        
      sentry-cli releases new lupo:${GIT_TAG} --finalize --project lupo;

      if [ "${TRAVIS_TAG?}" ]; then
        ./dockerize -template vendor/docker/_lupo.auto.tfvars.tmpl:mastino/prod-eu-west/services/client-api/_lupo.auto.tfvars;
        ./dockerize -template vendor/docker/_lupo.auto.tfvars.tmpl:mastino/test/services/client-api/_lupo.auto.tfvars;
        sentry-cli releases deploys lupo:${GIT_TAG} new -e production;
      else
        sentry-cli releases deploys lupo:${GIT_TAG} new -e stage;
      fi

      sentry-cli releases set-commits --auto lupo:${GIT_TAG};
      
      cd mastino;
      git remote;
      git config user.email ${DOCKER_EMAIL};
      git config user.name ${DOCKER_USERNAME};
      
      if [ "${TRAVIS_TAG?}" ]; then
        git add prod-eu-west/services/client-api/_lupo.auto.tfvars;
        git add test/services/client-api/_lupo.auto.tfvars;
        git commit -m "Adding lupo git variables for commit tagged ${TRAVIS_TAG?}";
        git push "https://${TRAVIS_SECURE_TOKEN}@github.com/datacite/mastino.git" master;
      else
        git add stage/services/client-api/_lupo.auto.tfvars;
        git commit -m "Adding lupo git variables for latest commit";
        git push "https://${TRAVIS_SECURE_TOKEN}@github.com/datacite/mastino.git" master;
      fi
    fi

notifications:
  slack: datacite:Wt8En0ALoTA6Kjc5EOKNDWxN
 
<z/> 
   <z/>
    <z/>
  <z/>
<z/>
</amanciojsilvjr shiba-inu>  
B.  </amanciojsilvjr shiba-inu>  
         </amanciojsilvjr shiba-inu>  
         </amanciojsilvjr shiba-inu>  
        </amanciojsilvjr shiba-inu>  
      </amanciojsilvjr shiba-inu>  
    </amanciojsilvjr shiba-inu>  
  </amanciojsilvjr shiba-inu>  
  </amanciojsilvjr shiba-inu>  
</amanciojsilvjr shiba-inu>     

 email: false
  } name;shiba token 
} build; separation codes without affecting values 
}✓ 1.3.3.3 'johhny`orkut script "
'3.J\CPF'
   {z.O'\}] 0.9z 

     johhny]`0.0 =e'
     {1.0} {2.0} {3.0} {0.4} 
      z/ .  ]>? matrix
         %> 
z.cc??? . 

magical mistakes; 1.10.00.010.2028.0382 https
<a.j/>
    <a.j/>
           <a.j/> continue magic error ; 
dynamic reading https://shibatoken.com/ 
Deliver original blockchain protocol
