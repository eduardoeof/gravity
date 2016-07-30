#!/user/bin/env ruby

require 'json'
require 'net/http'

require_relative 'glogger'

class LoLSeedDataConnector
  def initialize()
    @url = 'https://s3-us-west-1.amazonaws.com/riot-api/seed_data/'
    @log = GLogger.new(LoLSeedDataConnector.class)
  end

  def fetch(file_name)
    @log.info("Start download " + file_name)
    
    url = @url + file_name
    uri = URI(url)
    response = Net::HTTP.get(uri)
    
    @log.info("Download " + file_name + " succeed")

    return JSON.parse(convert_to_utf8(response))    
  end

  def convert_to_utf8(response)
    return response.force_encoding("iso-8859-1").encode("utf-8")  
  end
end

