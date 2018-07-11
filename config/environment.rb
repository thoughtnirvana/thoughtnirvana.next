require 'ostruct'
require 'sprockets'

$LOAD_PATH.unshift Dir.pwd

class Environment
  def self.config
    config = OpenStruct.new

    config.static_build_dir = '_build'


    config.assets = ['base.css'] +
      Dir['app/assets/images/**/*'].map{ |image_file| File.basename image_file }
    config.assets_sources = %w(app/assets/javascripts app/assets/stylesheets app/assets/images)
    config.assets_output_dir = 'assets'
    config.assets_output_path = File.join(config.static_build_dir, 'assets')
    config.assets_manifest_name = 'manifest.json'
    config.assets_manifest_path = File.join(config.assets_output_path, config.assets_manifest_name)

    config.sprockets_environment = Sprockets::Environment.new(Dir.pwd) do |env|
      env.logger = Logger.new $stdout
      env.logger.level = Logger::INFO
    end
    config.assets_sources.each { |source| config.sprockets_environment.append_path source }
    config.assets_manifest = Sprockets::Manifest.new config.sprockets_environment.index, config.assets_manifest_path

    config
  end
end
