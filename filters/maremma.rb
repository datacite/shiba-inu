require "faraday"

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

  conn = Faraday.new(:url => API_URL)
  json = conn.get "/works/#{event.get('doi')}"

  # query = "#{API_URL}/works/#{event[:doi]}"
  # json = Maremma.get(query).body.dig("data")
  # return "" unless json.respond_to?("dig")
  # puts json.body.class
  data = eval(json.body)
  # puts data.class

  attributes = data["data"]["attributes"]
  enriched = { 
    dataset_id: attributes[:doi],
    data_type: attributes["resource-type-id"],
    yop: attributes[:published],
    uri: attributes[:doi],
    publisher: attributes["data-center-id"],
    dataset_contributors: attributes[:author],
  }
  [LogStash::Event.new(enriched)]
end