require 'ostruct'
$LOAD_PATH.unshift Dir.pwd

class Environment
  def self.config
    config = OpenStruct.new
    config.static_build_dir = '_build'
    config.assets = ['base.css'] +
      Dir['app/assets/images/**/*'].map{ |image_file| File.basename image_file }
    config.assets_sources = %w(app/assets/javascripts app/assets/stylesheets app/assets/images)
    config.assets_output_dir = File.join(config.static_build_dir, 'assets')
    config.assets_manifest_name = 'manifest.json'
    config.assets_manifest_path = File.join(config.assets_output_dir, config.assets_manifest_name)

    config
  end
end
