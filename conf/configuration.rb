#!/usr/bin/env ruby

class Configuration
  @@gravity_dir_path = __dir__[0, __dir__.index(/\/conf$/)] 
 
  def self.log_dir_path
    return @@gravity_dir_path + '/log/'
  end

  def self.tmp_dir_path
    return @@gravity_dir_path + '/tmp/'
  end
end

