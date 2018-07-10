require_relative './base'
require 'yaml'

class Tenets < Base
  def self.all
    tenets_file_path = File.join(__dir__, 'tenets.yml')
    YAML.load_file(tenets_file_path)['tenets']
  end
end
