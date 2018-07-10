require 'fileutils'

namespace :static do
  desc 'Delete generated files'
  task :clean do
    FileUtils.rm_r Environment.config.static_build_dir
  end
end