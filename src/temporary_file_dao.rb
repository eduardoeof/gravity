#!/usr/bin/env ruby

require 'logger'

class TemporaryFileDAO
  def initialize
    @tmp_path = 'tmp/'
    @seeds_path = @tmp_path + 'seeds/'
    @log = Logger.new(STDOUT)
    @log.level = Logger::INFO
  end  

  def is_seed_file_exist(file_name)
    return File.file?(@seeds_path + file_name)
  end

  def save_seed_json(file_name, json)
    File.open(@seeds_path + file_name, 'w') do |file|
      file.write(json.to_json)
    end
    
    @log.info("File " + file_name + " saved in temporary diretory.")
  end
end

