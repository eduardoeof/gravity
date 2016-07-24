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
    seed_matches.each_slice(50).to_a.each do |slice|
      @collection.insert_many(slice)
    end    
  end
end

