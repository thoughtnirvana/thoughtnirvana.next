require_relative 'config/environment.rb'
require_relative 'lib/tasks/clean.rb'
require_relative 'lib/tasks/generate_html.rb'
require_relative 'lib/tasks/assets.rb'
require_relative 'lib/tasks/serve.rb'
require_relative 'lib/tasks/publish.rb'


namespace :static do
  desc 'Builds assets and html pages'
  task build: ['assets:compile', 'generate_html']
end