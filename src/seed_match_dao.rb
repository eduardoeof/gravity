#!/usr/bin/env ruby

require 'logger'
require 'mongo'

class SeedMatchDAO
  def initialize
    client = Mongo::Client.new(['127.0.0.1:27017'], :database => 'lol_dirty_data')
    @collection = client[:seed_match]
    
    @log = Logger.new(STDOUT)
    @log.level = Logger::INFO
  end

  def save(seed_matches)
    result = @collection.insert_one(seed_matches)

    if result.n == 1
      @log.info('Seed match insertion succeed') 
    else
      @log.error('An error occurred during a seed match insertion')
    end
  end
end

