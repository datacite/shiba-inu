# encoding: utf-8
require "spec_helper"

# Load the configuration file
@@configuration = String.new
@@configuration << File.read("./pipeline/06_filter_structuring.conf")


describe "Structuring" do
  let(:config) { @@configuration }

  contexts "when events is correct" do

    describe "correct date passes" do
      sample('occured_at' => '2018-04-02 00:09:39.543Z') do 
        expect("#{subject.get('@timestamp')}").to eq('2018-04-02T00:09:39.543Z')
        expect(subject.get('tags')).to_not include('_dateparsefailure')
        expect(subject.get('tags')).to include('dated')
      end
    end


    describe "incorrect date fails" do
      sample('occured_at' => '2018-04-02 00:09:39.43Z') do 
        # puts subject.get("occured_at")
        # puts subject.get("tags")
        # expect(subject.get('@timestamp')).not_to eq('2018-04-02 00:09:39.543Z')
        # expect(subject.get('tags')).to include('_dateparsefailure')
      end
    end

    describe "correct date in format quotes" do
      sample('occured_at' => '\"2018-04-01 00:09:31.394Z\"') do 
        expect("#{subject.get('@timestamp')}").to eq('2018-04-01T00:09:31.394Z')
        expect(subject.get('tags')).to_not include('_dateparsefailure')
        expect(subject.get('tags')).to include('dated')
      end
    end

    describe "correct date in format B" do
      sample('occured_at' => '2018-04-02 00:09:39.543Z') do 
        # expect(subject.get('tags')).to include('dated')

      end
    end



    describe "fails user agent trasnformation" do
      message = {"user_agent" => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"}

      sample(message) do 
        expect(subject.get('access-method')).to eq('regular')
        expect(subject.get('tags')).to include('UA')
      end
    end

  end

  contexts "when events is not correct" do

    # message = {"user_agent" => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"}


    # describe "fails user agent trasnformation" do
    #   sample(message) do 
    #     expect(subject.get('access-method')).to eq('regular')
    #     expect(subject.get('tags')).to include('UA')
    #   end
    # end

  end

end