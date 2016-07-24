#!/usr/bin/env ruby

require_relative 'lol_seed_data_connector'
require_relative 'temporary_file_dao'

class GravityController
  def initialize
    @seed_connector = LoLSeedDataConnector.new 
    @tmp_dao = TemporaryFileDAO.new 
  end

  def start_downloads
    for i in 1..10
      file_name = 'matches' + i.to_s + '.json'

      matches_json = nil
      if @tmp_dao.is_seed_file_exist(file_name)
        matches_json = @tmp_dao.load_seed_file(file_name)
      else
        matches_json = @seed_connector.fetch(file_name)
        @tmp_dao.save_seed_json(file_name=file_name, json=matches_json)
      end

      save_seed_matches_in_db(matches_json)
    end
  end 

  private def save_seed_matches_in_db(matches_json)
    puts 'File match:'
    matches_json['matches'].each do |match|
      puts match.to_s
      break
    end
  end   
end

