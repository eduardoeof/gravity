#!/usr/bin/env ruby

require_relative 'lol_seed_data_connector'
require_relative 'temporary_file_dao'

class GravityController
  def initialize
    @seed_connector = LoLSeedDataConnector.new 
    @tmp_dao = TemporaryFileDAO.new 
  end

  def start_downloads
    file_name = 'matches1.json'
    match_json = @seed_connector.fetch(file_name)

    @tmp_dao.save_seed_json(file_name=file_name, json=match_json)
  end    
end

