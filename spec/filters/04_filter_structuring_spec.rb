# encoding: utf-8
require "spec_helper"
# require_relative "../spec_helper.rb"


# Load the configuration file
@@configuration = String.new
@@configuration << File.open("./pipeline/04_filter_structuring.conf","rb").read


describe "Structuring" do
  let(:config) { @@configuration }

  context "Filters outs when  " do 
    message = {'occured_at' => '2018-04-02 00:09:39.543Z', 'doi' => '10.232/dsds', 'user_agent' => "dsdsdsdsd"}

    describe "correct date passes" do
      sample(message) do 
        puts subject
        expect("#{subject.get('@timestamp')}").to eq('2018-04-02T00:09:39.543Z')
        expect(subject.get('tags')).to_not include('_dateparsefailure')
        expect(subject.get('tags')).to include('dated')
      end
    end

    describe "correct date in format B" do
      sample(message) do 
        # expect(subject.get('tags')).to include('dated')
  
      end
    end

  end

  context "Filters outs when  " do 
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
  end

  context "Filters outs events without " do

    message = {'occured_at' => '2018-04-02 00:09:39.43Z', 'doi' => '', 'user_agent' => "dsdsdsdsd"}
    message_2 = {'occured_at' => '', 'doi' => '10.2323/fjhds3', 'user_agent' => "dsdsdsdsd"}
    message_3 = {'occured_at' => '2018-04-02 00:09:39.43Z', 'doi' => '10.2323/fjhds3', 'user_agent' => ""}

    describe "DOIs" do
      sample(message) do 
        expect(subject).to eq(nil)
      end
    end
    describe "timestamp" do
      sample(message_2) do 
        expect(subject).to eq(nil)
      end
    end
    describe "user agent" do
      sample(message_3) do 
        expect(subject).to eq(nil)
      end
    end
  end


  context "Does not Filters events with" do

    message = {'occured_at' => '2018-04-02 00:09:39.543Z', 'doi' => '10.2323/fjhds3', 'tags' => ['_ua']}

    describe "timestamp" do
      sample(message) do 
        expect("#{subject.get('occured_at')}").to eq('2018-04-02 00:09:39.543Z')
      end
    end

    describe "doi" do
      sample(message) do 
        expect(subject.get('doi')).to eq('10.2323/fjhds3')
      end
    end

    describe "user agent" do
      sample(message) do 
        expect(subject.get('user_agent')).to eq("dsdsdsdsd")
      end
    end
  end
end