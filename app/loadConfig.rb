class LoadConfig

  def load_white_list
    YAML::load_file(File.join(__dir__, 'white_list.yml'))
  end
end
