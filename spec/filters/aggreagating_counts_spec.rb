require "spec_helper"


describe "Double click filter" do
  let(:response)  { parse_reponse fixture_path + "reponses/unique_investigations"}
  let(:message)   {response.sample}

  context "A single message" do
    it "has attirbutes" do
      expect(message["message"]).not_to be_empty
      expect(message["doi"]).to match(/10\.\d{4,5}\/\S+/)
      expect(message["occurred_at"]).not_to be_empty
      expect(message["clientip"]).not_to be_empty
      expect(message["hour"].to_i).to be_kind_of(Numeric)
      expect(message["session"]).not_to be_empty
      expect(message["logdate"]).not_to be_empty
      expect(message["clicks"]).to be_kind_of(Numeric)
      expect(message["logdate"]).not_to be_empty
      expect(message["tags"]).to include("_aggregate_double_clicks")
      expect(message["unique_usage"]).not_to be_empty
      expect(message["total_usage"]).not_to be_empty
      expect(message["ua"]).not_to be_empty
      expect(message["unique_investigations"]).to be_kind_of(Numeric)
      expect(message["investigations"]).to be_kind_of(Numeric)

    end
    
    it "adds _unique_aggregated tag" do
      expect(message["_unique_aggregated"]).not_to be_empty
    end
  end

  context "Multiple messages" do
    it "don't get filtered" do
      messages = response
      expect(messages.size).to be 2
    end


    it "adds correct access-method" do
      messages = response
      file1 = messages.select {|m| m["access_method"] == "robot" }.first
      file2 = messages.select {|m| m["access_method"] == "regular" }.first    
      expect(file1["unique_investigations"]).to eq(6)
      expect(file2["unique_investigations"]).to eq(2)
    end
  end
end
