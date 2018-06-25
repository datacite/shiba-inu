# encoding: utf-8
require "spec_helper"
require_relative "../support/aggregate_spec_helper.rb"

# Load the configuration file
@@configuration = String.new
@@configuration << File.open("./pipeline/07_filter_aggregating.conf","rb").read

describe "Aggregating" do
  let(:config) { @@configuration }


  # context "when metadata is coorect" do

  #   message = [{'occured_at' => '2018-04-02 00:09:39.543Z', 'doi' => '10.2323/fjhds3', 'tags' => ['UA']}]


  #   describe "events by month" do
  #     sample(message) do 
  #       expect("#{subject.get('month-year')}").to eq('2018-04')
  #       expect(subject.get('count')).to eq(7)
  #       expect(subject.get('count')).to eq(7)

  #     end
  #   end
  #   describe "events by DOI" do
  #     sample(message_2) do 
  #       expect(subject).to eq(nil)
  #     end
  #   end
  # end


  context "events by DOI" do

    message = {'occured_at' => '2018-04-02 00:09:39.543Z', 'doi' => '10.2323/fjhds3', 'tags' => ['UA']}

    # messages = [message,message,message]

    describe "timestamp" do
      # puts config
      reset_pipeline_variables()
      sample(message) do 
        expect("#{subject.get('occured_at')}").to eq('2018-04-02 00:09:39.543Z')
      end
    end

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