#!/usr/bin/env ruby

require 'fileutils'

class TemporaryFileDAO
  def initialize
    @tmp_path = Configuration.tmp_dir_path
    @seeds_path = @tmp_path + 'seeds/'
    @log = GLogger.new(TemporaryFileDAO)

    create_dirs()
  end  

  def is_seed_file_exist(file_name)
    return File.file?(@seeds_path + file_name)
  end

  def save_seed_json(file_name, json)
    @log.info("Save file " + file_name + " in temporary diretory.")
    
    File.open(@seeds_path + file_name, 'w') do |file|
      file.write(json.to_json)
    end
  end

  def load_seed_file(file_name)
    @log.info("Load file " + file_name + " from temporary diretory.")
    
    file = File.read(@seeds_path + file_name)  
    return JSON.parse(file)
  end

  def delete_seed_files
    @log.info("Delete all seed files in tmp dir")
    
    FileUtils.rm_rf(@seeds_path)
  end

  private def create_dirs()
    Dir.mkdir(@tmp_path) unless File.exists?(@tmp_path)
    Dir.mkdir(@seeds_path) unless File.exists?(@seeds_path)
  end
end

