# encoding: utf-8
require "spec_helper"
require "logstash/filters/aggregate"

# require_relative "../support/aggregate_spec_helper.rb"

# Load the configuration file
@@configuration = String.new
@@configuration << File.open("./pipeline/07_filter_aggregating.conf","rb").read

describe "Aggregating" do
  let(:config) { @@configuration }


  context "unique investigations during the same day" do

    message = [
      { 'occured_at' => '2018-04-02 00:09:39.543Z', 
        'doi' => '10.2323/fjhds3', 
        'tags' => ['UA'],
        '@metadata' => {'unique_usage' => 'defd4334f'}
      },
      { 'occured_at' => '2018-04-03 00:09:39.543Z', 
        'doi' => '10.2323/fjhds3', 
        'tags' => ['UA'],
        '@metadata' => {'unique_usage' => 'defd4334f'}
      },
      { 'occured_at' => '2018-04-04 00:09:39.543Z', 
        'doi' => '10.2323/fjhds3', 
        'tags' => ['UA'],
        '@metadata' => {'unique_usage' => 'defd4334f'}
      }    
    ]


    describe "events by month" do
      sample(message) do 
        expect(subject.get('unique-investigations')).to eq(7)

      end
    end
  end


  context "events by DOI" do

    # message = {'occured_at' => '2018-04-02 00:09:39.543Z', 'doi' => '10.2323/fjhds3', 'tags' => ['UA']}

    # # messages = [message,message,message]

    # describe "timestamp" do
    #   # puts config
    #   reset_pipeline_variables()
    #   sample(message) do 
    #     expect("#{subject.get('occured_at')}").to eq('2018-04-02 00:09:39.543Z')
    #   end
    # end

    # describe "doi" do
    #   sample(message) do 
    #     expect(subject.get('investigations')).to eq(3)
    #   end
    # end

    # describe "user agent" do
    #   sample(message) do 
    #     expect(subject.get('tags')).to include('UA')
    #   end
    # end
  end
end