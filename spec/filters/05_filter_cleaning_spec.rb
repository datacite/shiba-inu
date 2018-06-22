# encoding: utf-8
require "spec_helper"

# Load the configuration file
@@configuration = String.new
@@configuration << File.read("./pipeline/05_filter_cleaning.conf")


describe "Cleaning" do
  let(:config) { @@configuration }


  context "Filters outs events without " do

    message = {'occured_at' => '2018-04-02 00:09:39.43Z', 'doi' => '', 'tags' => ['UA']}
    message_2 = {'occured_at' => '', 'doi' => '10.2323/fjhds3', 'tags' => ['UA']}
    message_3 = {'occured_at' => '2018-04-02 00:09:39.43Z', 'doi' => '10.2323/fjhds3', 'tags' => ['HOLA']}

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

    message = {'occured_at' => '2018-04-02 00:09:39.543Z', 'doi' => '10.2323/fjhds3', 'tags' => ['UA']}

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
        expect(subject.get('tags')).to include('UA')
      end
    end
  end
end