require "faraday"
require 'json'

API_URL = "https://api.datacite.org"

# the value of `params` is the value of the hash passed to `script_params`
# in the logstash configuration
def register(params)
  @params = params
end

# the filter method receives an event and must return a list of events.
# Dropping an event means not including it in the return array,
# while creating new ones only requires you to add a new instance of
# LogStash::Event to the returned array
def filter(event)
  total = event.get("[dois][buckets]")
  dois = total.map do |dataset| 

    unique_regular = dataset["access_method"]["buckets"].find {|access_method| access_method['key'] == 'regular' }
    unique_machine = dataset["access_method"]["buckets"].find {|access_method| access_method['key'] == 'machine' }
    total_regular  = dataset["total"]["buckets"].find {|access_method| access_method['key'] == 'regular' }
    total_machine  = dataset["total"]["buckets"].find {|access_method| access_method['key'] == 'machine' }

    puts dataset["key"]
    { 
      doi: dataset["key"], 
      unique_counts_regular: unique_regular.nil? ? 0 : unique_regular["unqiue"]["value"],
      unique_counts_machine: unique_machine.nil? ? 0 : unique_machine["unqiue"]["value"],
      total_counts_regular: total_regular.nil? ? 0 : total_regular["doc_count"],
      total_counts_machine: total_machine.nil? ? 0:  total_machine["doc_count"]
    }
  end

  conn = Faraday.new(:url => API_URL)
  logger = Logger.new(STDOUT)
  
  arr = dois.map do |dataset| 
    logger.info dataset
    doi = dataset[:doi]
    json = conn.get "/works/#{doi}"
    next unless json.success?
    logger.info "Success on getting metadata for #{doi}"
    data = JSON.parse(json.body)
    attributes = data["data"]["attributes"]
    { 
      dataset_id: {type: "doi", value: attributes["doi"]},
      data_type: attributes["resource-type-id"],
      yop: attributes["published"],
      uri: attributes["url"],
      publisher: attributes["container-title"],
      dataset_title: attributes["title"],
      publisher_id: [{
        type: "grid",
        value: attributes["data-center-id"]
      }],
      dataset_dates: [{
        type: "pub-date",
        value: attributes["published"]
      }],
      dataset_contributors: attributes["author"].map { |a| get_authors(a) },
      tags:["_dc_meta"],
      performance: [{
        period: {
          begin_date: "",
          end_date: "",
        },
        instance:[
          {
            count: dataset[:total_counts_regular],
            access_method: "regular",
            metric_type: "total_dataset_investigations"
          },
          {
            count: dataset[:unique_counts_regular],
            access_method: "regular",
            metric_type: "unique_dataset_investigations"
          },
          {
            count: dataset[:unique_counts_machine],
            access_method: "machine",
            metric_type: "unique_dataset_investigations"
          },
          {
            count: dataset[:total_counts_machine],
            access_method: "machine",
            metric_type: "total_dataset_investigations"
          },
        ]
      }]
      # unique_counts_regular: dataset[:unique_counts_regular],
      # unique_counts_machine: dataset[:unique_counts_machine],
      # total_counts_regular: dataset[:total_counts_regular],
      # total_counts_machine: dataset[:total_counts_machine],
    }
    #.transform_keys!{ |key| key.to_s.dasherize }
  end

  arr.map! do |instance|
    LogStash::Event.new(instance)
  end

  arr
end


def get_authors author
  if (author.key?("given") || author.key?("family"))
    { type: "name",
      value: author["given"]+" "+author["family"] }
    elsif author.key?("literal")
      { type: "name",
        value: author["literal"] }
    else 
      { type: "name",
        value: "" }
  end
end