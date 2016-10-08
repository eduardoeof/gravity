#!/usr/bin/env ruby

class GravityController
  def initialize
    @game_connector = LoLRecentGameConnector.new 
    @seed_connector = LoLSeedDataConnector.new 
    
    @tmp_dao = TemporaryFileDAO.new 
    @seed_dao = SeedMatchDAO.new
    @summoner_dao = SummonerDAO.new 
    @game_dao = RecentGameDAO.new
    
    @log = GLogger.new(GravityController)
  end

  def load_recent_games
    @log.info("Gravity start loading recent games data!")
    
    @summoner_dao.load_summoner_ids().each do |summoner_id|
      games = @game_connector.fetch_games(summoner_id)

      if games.nil?
        @log.error("Games of summoner #{summoner_id} is nil ")
        next
      end

      new_games = search_new_games(games, summoner_id) 

      if new_games.empty?
        @log.warn("Summoner #{summoner_id} doesn't have new games")
        next
      end

      @game_dao.save(new_games, summoner_id) 
    end 
    
    @log.info("Gravity finished recent games load. That\'s all folks!")
  end

  def load_seed_data 
    @log.info("Gravity start loading seed data!")

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
 
    @log.info("Gravity finished seed data load. That\'s all folks!")
  end 
  
  # Private

  private def search_new_games(games, summoner_id)
    new_games = []
    games.each do |game|
      if !@game_dao.exists?(game, summoner_id)
        new_games << game
      end
    end

    return new_games
  end
end

