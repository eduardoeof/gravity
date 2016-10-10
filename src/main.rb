#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'controller/gravity_controller'
require 'connector/lol_recent_game_connector'
require 'connector/lol_seed_data_connector'
require 'connector/lol_rate_limit_validator'
require 'support/glogger'
require 'dao/seed_match_dao'
require 'dao/temporary_file_dao'
require 'dao/summoner_dao'
require 'dao/recent_game_dao'

require_relative '../conf/configuration'

if __FILE__ == $0
  controller = GravityController.new()
  
  if ARGV.empty?
    controller.load_recent_games()
  else
    ARGV.each do |arg|
      if arg == '-s' || arg == '--seed'
        controller.load_seed_data()
      elsif arg == '-g' || arg == '--game'
        controller.load_recent_games()
      elsif arg == '-a' || arg == '--all'
        controller.load_seed_data()
        controller.load_recent_games()
      end
    end
  end
end

