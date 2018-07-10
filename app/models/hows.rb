require_relative './base'
require 'yaml'

class Hows < Base
  def self.all
    hows_file_path = File.join(__dir__, 'hows.yml')
    YAML.load_file(hows_file_path)['hows']
  end
end