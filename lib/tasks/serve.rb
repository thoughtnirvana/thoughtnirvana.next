require 'webrick'

namespace :static do
  desc 'Serve built site'
  task :serve, [:port, :root] do |t, args|
    args.with_defaults(port: Environment.config.static_serve_port,
      root: Environment.config.static_build_dir)
    server = WEBrick::HTTPServer.new(:Port => args.port, :DocumentRoot => args.root)
    trap('INT') { server.shutdown }
    server.start
  end
end
