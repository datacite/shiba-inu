require "spec_helper"


describe "Double click filter" do
  let(:response)  { parse_reponse fixture_path + "/reponses/user_agent_response"}
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
      expect(message["clicks"]).not_to be_empty
      expect(message["logdate"]).not_to be_empty
      expect(message["tags"]).to include("_aggregate_user_agents")
      expect(message["unique_usage"]).not_to be_empty
      expect(message["total_usage"]).not_to be_empty
    end
    
    it "adds ua field and remove user-agent" do
      expect(message["ua"]).not_to be_empty
      expect(message["user_agent"]).to be_empty
    end

    it "adds correct access-method" do
      expect(message["access_method"]).to eq("Robot")
    end

    it "creates unque_usage and total usage" do
      expect(message["unique_usage"]).to eq(message["session"]+message["access_method"])
      expect(message["total_usage"]).to eq(message["doi"]+message["access_method"])
    end
  end

  context "Multiple messages" do
    it "don't get filtered" do
      messages = response
      expect(messages.size).to be 2
    end
  end
end
