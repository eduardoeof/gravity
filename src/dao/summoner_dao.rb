#!/usr/bin/env ruby

require 'mongo'

class SummonerDAO
  def initialize
    change_mongo_logger_level()
    
    client = create_mongo_client()
    @collection = client[:summoner]
    
    @log = GLogger.new(SummonerDAO)
  end
 
  def load_summoner_ids
    @log.info("Load summonerIds from database")

    summoners = @collection.find({}, {'summonerId' => true})

    return summoners.map { |s| s['summonerId'] }
  end
 
  private def create_mongo_client
    return Mongo::Client.new(['127.0.0.1:27017'], :database => 'lol_clean_data')
  end

  private def change_mongo_logger_level
    Mongo::Logger.logger.level = ::Logger::ERROR
  end
end

