#!/usr/bin/env ruby

require 'logger'
require 'mongo'

require_relative 'glogger'

class SeedMatchDAO
  def initialize
    change_mongo_logger_level() 
    
    client = create_mongo_client()
    @collection = client[:seed_match]
    
    @log = GLogger.new(SeedMatchDAO)
  end

  def save(seed_matches)
    @log.info("Save #{seed_matches.count} matches in database")

    seed_matches.each_slice(50).to_a.each do |slice|
      @collection.insert_many(slice)
    end    
  end

  private def create_mongo_client
    return Mongo::Client.new(['127.0.0.1:27017'], :database => 'lol_dirty_data')
  end

  private def change_mongo_logger_level
    Mongo::Logger.logger.level = ::Logger::ERROR
  end
end

