#!/usr/bin/env ruby

require_relative 'lol_seed_data_connector'

class GravityController
  def initialize
    @seed_connector = LoLSeedDataConnector.new 
  end

  def start_downloads
    file = @seed_connector.fetch(file_name='matches1.json')
    puts file
  end    
end

