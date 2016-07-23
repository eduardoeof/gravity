#!/usr/bin/env ruby

require 'logger'

require_relative 'gravity_controller'

if __FILE__ == $0
  log = Logger.new(STDOUT)
  log.level = Logger::INFO

  log.info("Gravity start running!")

  controller = GravityController.new()
  controller.start_downloads()
  
  log.info("Gravity finished its job. That\'s all folks!")
end

