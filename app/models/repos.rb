require_relative './base'
require 'yaml'

class Repos < Base
  def self.all
    repos_file_path = File.join(__dir__, 'repos.yml')
    YAML.load_file(repos_file_path)['repos']
  end
end