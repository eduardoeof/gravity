#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'controller/gravity_controller'
require 'connector/lol_recent_game_connector'
require 'connector/lol_seed_data_connector'
require 'support/glogger'
require 'dao/seed_match_dao'
require 'dao/temporary_file_dao'
require 'dao/summoner_dao'
require 'dao/recent_game_dao'

if __FILE__ == $0
  controller = GravityController.new()
  controller.load_recent_games()
end

