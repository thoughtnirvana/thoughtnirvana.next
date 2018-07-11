namespace :assets do
  desc 'Compile assets'
  task :compile do
    Environment.config.assets_manifest.compile(*Environment.config.assets)
  end

  desc 'Clean assets'
  task :clean do
    Environment.config.assets_manifest.clean
  end

  desc 'Remove all assets'
  task :clobber do
    Environment.config.assets_manifest.clobber
  end
end