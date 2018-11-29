require 'yaml'

class ConfigLoad

  def self.load_white_list
    YAML::load_file(File.join(__dir__, '../config/white_list.yml'))
  end
end
