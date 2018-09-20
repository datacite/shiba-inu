require "spec_helper"


describe "Double click filter" do
  let(:response)  { parse_reponse fixture_path + "/reponses/double_click_response"}

  context "A single message" do
    it "has attirbutes" do
      message = response.sample
      expect(message["message"]).not_to be_empty
      expect(message["user_agent"]).not_to be_empty
      expect(message["doi"]).to match(/10\.\d{4,5}\/\S+/)
      expect(message["occurred_at"]).not_to be_empty
      expect(message["clientip"]).not_to be_empty
      expect(message["hour"].to_i).to be_kind_of(Numeric)
      expect(message["session"]).not_to be_empty
      expect(message["logdate"]).not_to be_empty
    end
    
    it "formats user agent" do
      message = response.sample
      expect(message["user_agent"]).not_to be_empty
    end

    it "session is correct" do
      message = response.sample
      session = message["logdate"]+"_"+message["hour"]+"_"+message["doi"]+"_"+message["clientip"]+"_"+message["user_agent"]
      expect(message["session"]).to eq(session)
    end

    it "it has tag" do
      message = response.sample
      expect(message["tags"]).to include("_aggregate_double_clicks")
    end

    it "Aggregated click" do
      message = response.sample
      expect(message["clicks"].to_i).to be_kind_of(Numeric)
    end

    it "click counts are consistent" do
      message = response.sample
      ## check 
      if (((message["several_clicks"] == true) && (message["clicks"] > 1)) || ((message["several_clicks"] == false) && (message["clicks"] == 1)))
        consistent = true
      else
        consistent = false
      end 
      expect(consistent).to be(true)
    end
  end

  context "Multiple messages same session within 3 minutes" do
    let(:logs)  { parse_reponse fixture_path + "/inputs/double_click"}

    it "don't get filtered" do
      messages = response
      expect(messages.size).to be 2
    end

    it "aggregated counts by double click is correct" do
      messages = response
      single_clicks = messages.select {|m| m["doi"] == "10.5438/0000-00SS" }.first
      multiple_clicks= messages.select {|m| m["doi"] == "10.5063/schema/codemeta-2.0" }.first
      expect(multiple_clicks["clicks"]).to be 5
      expect(single_clicks["clicks"]).to be 1
    end

    it "aggregated session by double click is correct" do
      messages = response
      expect(messages.size).to be 2
    end
  end

  context "Multiple messages different session" do
    let(:logs)  { parse_reponse fixture_path + "/inputs/double_click_diff_sessions"}
    let(:response)  { parse_reponse fixture_path + "/reponses/double_click_different_session"}

    it "don't get filtered" do
      messages = response
      expect(messages.size).to be 5
    end

    it "aggregated counts by double click is correct" do
      messages = response
      single_clicks = messages.select {|m| m["doi"] == "10.5438/0000-00SS" }.first
      expect(single_clicks["clicks"]).to be 1
      multiple_clicks= messages.select {|m| m["doi"] == "10.5063/schema/codemeta-2.0" }
      expect(multiple_clicks.size).to be 4
    end


    it "aggregated counts by double click in different sessions is correct " do
      messages = response

      message_first= messages.select {|m| m["logdate"] == "2018-04-01" }
      message_third= messages.select {|m| m["logdate"] == "2018-04-03" }.first
      multiple_clicks= messages.select {|m| m["clicks"] == 2 }.first
      expect(message_first.size).to eq(4)
      expect(message_third["clicks"]).to be 1
      expect(multiple_clicks["logdate"]).to eq("2018-04-01")
    end

    it "aggregated session by double click is correct" do
      messages = response
      expect(messages.size).to be 5
    end
  end
end
