#!/usr/bin/env ruby

require 'logger'

class GLogger
  def initialize(owner_class)
    @owner_class_name = owner_class.name

    @log_path = 'log/'
    create_dir(@log_path)

    log_file = 'gravity_log_' + fetch_date_today() + '.txt'
    logger_file = Logger.new(@log_path + log_file)
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

  private def create_dir(dir_path)
    Dir.mkdir(dir_path) unless File.exists?(dir_path)
  end

  private def fetch_date_today
    return Time.new.strftime("%Y%m%d")
  end
end

