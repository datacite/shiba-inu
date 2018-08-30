require "spec_helper"


describe "Double click filter" do
  let(:response)  { parse_reponse fixture_path + "reponses/user_agent_response"}
  let(:message)   {response.sample}

  context "A single message" do
    it "has attirbutes" do
      expect(message["message"]).not_to be_empty
      expect(message["doi"]).to match(/10\.\d{4,5}\/\S+/)
      expect(message["occured_at"]).not_to be_empty
      expect(message["clientip"]).not_to be_empty
      expect(message["hour"].to_i).to be_kind_of(Numeric)
      expect(message["session"]).not_to be_empty
      expect(message["logdate"]).not_to be_empty
      expect(message["clicks"]).to be_kind_of(Numeric)
      expect(message["logdate"]).not_to be_empty
      expect(message["tags"]).to include("_aggregate_double_clicks")
      expect(message["unique_usage"]).not_to be_empty
      expect(message["total_usage"]).not_to be_empty
    end
    
    it "adds ua field and remove user-agent" do
      expect(message["ua"]).not_to be_empty
      expect(message["user_agent"]).to be_nil
    end

    it "creates unque_usage and total usage" do
      expect(message["unique_usage"]).to eq(message["session"]+"_"+message["access_method"])
      expect(message["total_usage"]).to eq(message["doi"]+"_"+message["access_method"])
    end
  end

  context "Multiple messages" do
    it "don't get filtered" do
      messages = response
      expect(messages.size).to be 2
    end


    it "adds correct access-method" do
      messages = response
      file1 = messages.select {|m| m["doi"] == "10.5438/0000-00SS" }.first
      file2 = messages.select {|m| m["doi"] == "10.5063/schema/codemeta-2.0" }.first    
      expect(file1["access_method"]).to eq("robot")
      expect(file2["access_method"]).to eq("machine")
    end
  end
end
