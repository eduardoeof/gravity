#!/usr/bin/env ruby

class TemporaryFileDAO
  def initialize
    @tmp_path = '../tmp/'
    @seeds_path = @tmp_path + 'seeds/'
  end  

  def save_seed_json(file_name, json)
    File.open(@seeds_path + file_name, 'w') do |file|
      file.write(json.to_json)
    end
  end
end

