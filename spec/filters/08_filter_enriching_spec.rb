# encoding: utf-8
require "spec_helper"

# Load the configuration file
@@configuration = String.new
@@configuration << File.read("./pipeline/08_filter_enriching.conf")


describe "Enriching" do
  let(:config) { @@configuration }

  describe "added DataCite Metadata" do
    sample('doi' => '10.5438/0000-00SS') do 
      expect("#{subject.get('@timestamp')}").to eq('2018-04-02T00:09:39.543Z')
      expect(subject.get('tags')).to_not include('_dateparsefailure')
      expect(subject.get('tags')).to include('dated')
    end
  end


  describe "added IP information" do
    sample('occured_at' => '2018-04-02 00:09:39.43Z') do 

    end
  end

  describe "correct date in format quotes" do
    sample('occured_at' => '\"2018-04-01 00:09:31.394Z\"') do 

    end
  end

  describe "drop if DOI is empty" do
    sample('doi' => '') do 

    end
  end

end