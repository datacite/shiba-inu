# encoding: utf-8
require "spec_helper.rb"

module LogStash::Environment
  # running the grok code outside a logstash package means
  # LOGSTASH_HOME will not be defined, so let's set it here
  # before requiring the grok filter
  unless self.const_defined?(:LOGSTASH_HOME)
    LOGSTASH_HOME = File.expand_path("../../../", __FILE__)
  end

  # also :pattern_path method must exist so we define it too
  unless self.method_defined?(:pattern_path)
    def pattern_path(path)
      ::File.join(LOGSTASH_HOME, "patterns", path)
    end
  end
end

require "logstash/filters/grok"

describe LogStash::Filters::Grok do



# Load the configuration file
puts "slasas"
# @@configuration = String.new
# @@configuration << File.read("./pipeline/08_filter_enriching.conf")


describe "structuring with user agent" do

  # config(@@configuration)
  let(:config) { File.read("./pipeline/03_filter_discovery.conf") }
  

  # Inject input event/message into the pipeline
  message = File.read('./spec/fixtures/complete_entry.log')
  
  sample('message' => message) do 
      # Check the ouput event/message properties
    # insist { subject.get("type") } == "doi"
    # insist { subject.get("@timestamp").to_iso8601 } == "2016-09-05T20:06:17.000Z"
    # insist { subject.get("verb") } == "GET"
    # insist { subject.get("request") } == "/images/logos/hubpress.png"
    # insist { subject.get("response") } == 200
    # insist { subject.get("bytes") } == 5432
    # reject { subject.get("tags").include?("_grokparsefailure") }
    # reject { subject.get("tags").include?("_dateparsefailure") }

    # expect(subject).to include('rest')
    puts subject
    # expect(subject.get('[rest][0]')).to include('userId')
    # expect(subject.get('[rest][0][userId]')).to eq(10)
    # expect(subject.get('rest')).to_not include('fallback')
  end
end
end