#!/usr/bin/env ruby

require_relative 'lol_seed_data_connector'
require_relative 'seed_match_dao'
require_relative 'temporary_file_dao'

class GravityController
  def initialize
    @seed_connector = LoLSeedDataConnector.new 
    @tmp_dao = TemporaryFileDAO.new 
    @seed_dao = SeedMatchDAO.new 
    @log = GLogger.new(GravityController)
  end

  def start_downloads
    @log.info("Gravity start running!")

    for i in 1..10
      file_name = 'matches' + i.to_s + '.json'

      matches_json = nil
      if @tmp_dao.is_seed_file_exist(file_name)
        matches_json = @tmp_dao.load_seed_file(file_name)
      else
        matches_json = @seed_connector.fetch(file_name)
        @tmp_dao.save_seed_json(file_name=file_name, json=matches_json)
      end
     
      @seed_dao.save(matches_json['matches'])
    end

    @tmp_dao.delete_seed_files()    
 
    @log.info("Gravity finished its job. That\'s all folks!")
  end 
end

