#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'controller/gravity_controller'

require 'lol_seed_data_connector'
require 'glogger'
require 'seed_match_dao'
require 'temporary_file_dao'

if __FILE__ == $0
  controller = GravityController.new()
  controller.start_downloads()
end

