#!/usr/bin/env ruby

require_relative 'glogger'

require_relative 'gravity_controller'

if __FILE__ == $0
  controller = GravityController.new()
  controller.start_downloads()
end

