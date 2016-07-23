#!/user/bin/env ruby

require 'json'
require 'logger'
require 'net/http'

class LoLSeedDataConnector
  def initialize()
    @url = 'https://s3-us-west-1.amazonaws.com/riot-api/seed_data/'
    @log = Logger.new(STDOUT)
    @log.level = Logger::INFO
  end

  def fetch(file_name)
    @log.info("Start download " + file_name)
    
    url = @url + file_name
    uri = URI(url)
    response = Net::HTTP.get(uri)
    
    @log.info("Download " + file_name + " succeed")
   
    return JSON.parse(response)    
  end
end

