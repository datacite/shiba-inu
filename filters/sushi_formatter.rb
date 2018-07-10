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
  performance = { 
    dataset_id: event[:doi],
    data_type: event[:dc_metadata]["resource-type-id"],
    yop: event[:dc_metadata][:published],
    uri: event[:dc_metadata][:doi],
    publisher: event[:dc_metadata]["data-center-id"],
    dataset_contributors: event[:dc_metadata][:author],
    instance:{
      access_method: event["access-method"],
      metric_type: event["total-investigations"].key,
      count: event["total-investigations"],
    }
  }
  [LogStash::Event.new(performance)]
end