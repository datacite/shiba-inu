
# Load the configuration file
@@configuration = String.new
@@configuration << File.read("./pipeline/03_filter_discovery.conf")


describe "structuring with user agent" do

  # config(@@configuration)
  let(:config) { File.open("./pipeline/03_filter_discovery.conf","rb").read }
  

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
    puts subject.get("doi")
    # expect(subject.get('[rest][0]')).to include('userId')
    # expect(subject.get('[rest][0][userId]')).to eq(10)
    # expect(subject.get('rest')).to_not include('fallback')
  end
end
