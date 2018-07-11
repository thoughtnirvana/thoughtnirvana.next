require 'sprockets'

environment = Sprockets::Environment.new(Dir.pwd) do |env|
  env.logger = Logger.new $stdout
  env.logger.level = Logger::INFO
end
Environment.config.assets_sources.each { |source| environment.append_path source }
manifest = Sprockets::Manifest.new environment.index, Environment.config.assets_manifest_path


namespace :assets do
  desc 'Compile assets'
  task :compile do
    manifest.compile(*Environment.config.assets)
  end

  desc 'Clean assets'
  task :clean do
    manifest.clean
  end

  desc 'Remove all assets'
  task :clobber do
    manifest.clobber
  end
end