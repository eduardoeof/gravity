#!/user/bin/env ruby

require 'net/http'
require 'json'

class LoLSeedDataConnector
  def initialize()
    @url = 'https://s3-us-west-1.amazonaws.com/riot-api/seed_data/'
  end

  def fetch(file_name)
    url = @url + file_name
    uri = URI(url)
    response = Net::HTTP.get(uri)
    return JSON.parse(response)    
  end
end

