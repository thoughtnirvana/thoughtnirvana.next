#!/usr/bin/env ruby
require 'slim'
require 'yaml'
require 'digest'

class Env 
  def initialize(scope={})
    scope.each {|k, v| define_singleton_method(k, proc { v }) }
    @layout = Slim::Template.new('layout.html.slim') 
  end

  def render(template, layout=true)
    contents = Slim::Template.new(template).render(self)
    return contents if not layout
    @layout.render(self) { contents }
  end

  def link_tag(filename, rel, type)
    <<-EOF
    <link href="#{filename}" rel="#{rel}" type="#{type}" />
    EOF
  end

  def css_tag(filename)
    link_tag(filename, rel="stylesheet/css", type="text/css")
  end

  def less_tag(filename)
    link_tag(filename, rel="stylesheet/less", type="text/css")
  end

  def js_tag(filename)
    <<-EOF
    <script src="#{filename}" type="text/javascript"></script>
    EOF
  end

  private
  def sha1_digest(filename)
    digest = Digest::MD5.new
    File.open(filename) do |f|
        digest.update f.read(8192) until f.eof
    end
    digest.hexdigest
  end
end

def index
  tenets = YAML.load_file('data/tenets.yml')['tenets']
  services = YAML.load_file('data/services.yml')['services']
  scope = Env.new(tenets: tenets, services: services)
  scope.render('index.html.slim')
end

def code
  Env.new.render('code.html.slim')
end

if __FILE__ == $0
  pages = [:index, :code]
  pages.each do |page|
    File.open("#{page.to_s}.html", 'w') {|f| f << send(page) }
  end
end
