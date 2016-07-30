#!/usr/bin/env ruby

require 'logger'

class GLogger
  def initialize(owner_class=nil)
    if !owner_class.nil?
      @owner_class_name = owner_class.name
    end    

    log_file = 'gravity_log.txt'
    logger_file = Logger.new(log_file)
    logger_stdout = Logger.new(STDOUT)

    @loggers = [logger_file, logger_stdout]
    define_loggers_level()
  end

  def info(message)
    @loggers.each do |logger|
      logger.info(message)
    end
  end 

  def error(message)
    @loggers.each do |logger|
      logger.error(message)
    end
  end

  private def define_loggers_level
    if @loggers.nil? 
      @loggers.each do |logger|
        logger.level = Logger::INFO
      end
    end
  end
end

