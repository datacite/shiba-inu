require "json"
require 'date'

  def parse_reponse file
    file = File.open("#{file}.json","rb").read
    x=""
    file.each_line do |line|
      x+= "#{line}"+","
    end
    JSON.parse("[#{x.chop}]")
  end
