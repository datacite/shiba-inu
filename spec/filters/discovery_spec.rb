require "spec_helper"


describe "Discovery filter" do
  let(:response)  { parse_reponse fixture_path + "/reponses/discovery_response"}

  context "grokking single message" do
    it "has attirbutes" do
      message = response.sample
      expect(message["message"]).not_to be_empty
      expect(message["user_agent"]).not_to be_empty
      expect(message["doi"]).to match(/10\.\d{4,5}\/\S+/)
      expect(message["occurred_at"]).not_to be_empty
      expect(message["clientip"]).not_to be_empty
      expect(message["hour"].to_i).to be_kind_of(Numeric)
      expect(message["logdate"]).not_to be_empty
    end
    
    it "has tags" do
      message = response.sample
      expect(message["tags"]).to include("_groked")
    end

    it "has logdate" do
      message = response.sample
      expect(Date.parse(message["logdate"])).to be_kind_of(Date)
    end
  end

  context "messages filtering" do
    it "don't get filtered" do
      messages = response
      expect(messages.size).to be > 2
    end
  end
end
