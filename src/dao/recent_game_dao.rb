#!/usr/bin/env ruby

require 'mongo'

class RecentGameDAO
  def initialize
    change_mongo_logger_level() 
    
    client = create_mongo_client()
    @collection = client[:recent_game]
    
    @log = GLogger.new(RecentGameDAO)
  end

  def exists?(game, summoner_id)
    raise ArgumentError, 'Parameter game is nil' unless !game.nil?
    raise ArgumentError, 'Parameter summoner_id is nil' unless !summoner_id.nil?

    game_id = game["gameId"]
    query_result = @collection.find({"gameId": game_id, "ownerSummonerId": summoner_id}, {"_id": 1})
      .limit(1)
      .count()

    return !query_result.nil? && query_result > 0
  end

  def save(games, summoner_id)
    raise ArgumentError, 'Parameter games is nil or empty' unless !games.nil? && !games.empty?
    raise ArgumentError, 'Parameter summoner_id is nil' unless !summoner_id.nil?
  
    @log.info("Save #{games.count} games of summoner #{summoner_id}")

    add_summoner_id_in_games(games, summoner_id)

    @collection.insert_many(games)
  end

  # Private methods

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
end

