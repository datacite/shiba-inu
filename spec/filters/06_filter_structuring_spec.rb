# encoding: utf-8
require "spec_helper"

# Load the configuration file
@@configuration = String.new
@@configuration << File.read("./pipeline/06_filter_structuring.conf")


describe "Structuring" do
  let(:config) { @@configuration }

  context "when user_agent is in the list" do

    describe "and is a robot, then classify it as a robot" do
      message = {"user_agent" => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"}
      sample(message) do 
        expect(subject.get('access-method')).to eq('regular')
        expect(subject.get('tags')).to include('_ua')
      end
    end


    describe "and is a machine, then classify it as a machine" do
      message = {"user_agent" => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"}
      sample(message) do 
                # puts subject.get("occured_at")
        # puts subject.get("tags")
        # expect(subject.get('@timestamp')).not_to eq('2018-04-02 00:09:39.543Z')
        # expect(subject.get('tags')).to include('_dateparsefailure')
      end
    end

    describe "and is a unclassified, then classify it as a unclassified" do
      message = {"user_agent" => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"}
      sample(message) do 

      end
    end

    describe "fails user agent trasnformation" do
      message = {"user_agent" => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"}
      sample(message) do 
        expect(subject.get('access-method')).to eq('regular')
        expect(subject.get('tags')).to include('_ua')
      end
    end

  end

  context "when events is not correct" do

    # message = {"user_agent" => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"}


    # describe "fails user agent trasnformation" do
    #   sample(message) do 
    #     expect(subject.get('access-method')).to eq('regular')
    #     expect(subject.get('tags')).to include('_ua')
    #   end
    # end

  end

end