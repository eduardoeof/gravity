#!/usr/bin/env ruby

require 'mongo'

class RecentGameDAO
  def initialize
    change_mongo_logger_level() 
    
    client = create_mongo_client()
    @collection = client[:recent_game]

    @log = GLogger.new(RecentGameDAO)
  end

  def save(games, summoner_id)
    if !is_save_inputs_valid(games, summoner_id)
      return
    end
  
    @log.info("Save #{games.count} games of summoner #{summoner_id}")

    add_summoner_id_in_games(games, summoner_id)

    @collection.insert_many(games)
  end

  private def create_mongo_client
    return Mongo::Client.new(['127.0.0.1:27017'], :database => 'lol_dirty_data')
  end

  private def change_mongo_logger_level
    Mongo::Logger.logger.level = ::Logger::ERROR
  end

  private def add_summoner_id_in_games(games, summoner_id)
    games.each do |game|
      game['ownerSummonerId'] = summoner_id
    end
  end

  private def is_save_inputs_valid(games, summoner_id)
    if games.nil? || games.count == 0
      @log.error('Parameter games is nil or doesn\'t have games')
      return false
    elsif summoner_id.nil?
      @log.error('Parameter summoner_id is nil')
      return false
    end

    return true
  end
end

