require_relative './base'
require 'yaml'

class Services < Base
  def self.all
    services_file_path = File.join(__dir__, 'services.yml')
    YAML.load_file(services_file_path)['services']
  end
end
