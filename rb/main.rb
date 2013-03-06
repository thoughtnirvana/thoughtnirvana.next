#!/usr/bin/env ruby
require 'slim'
require 'yaml'
require 'digest'
require 'ruby-debug'

$rb_dir = File.dirname(__FILE__)
$prod = false

class Env
  def initialize(scope={})
    scope.each {|k, v| define_singleton_method(k, proc { v }) }
    @layout = Slim::Template.new(File.join($rb_dir, 'layout.html.slim'))
  end

  def render(template, layout=true)
    contents = Slim::Template.new(File.join($rb_dir, template)).render(self)
    return contents if not layout
    @layout.render(self) { contents }
  end

  def link_tag(filename, rel, type)
    filename = with_digest(filename) if $prod
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
    filename = with_digest(filename) if $prod
    <<-EOF
    <script src="#{filename}" type="text/javascript"></script>
    EOF
  end

  def img_tag(filename, opts)
    opts = opts.reduce('') {|accum, (k, v)| "#{accum} #{k}=\"#{v}\"" }
    filename = with_digest(filename) if $prod
    <<-EOF
    <img src="#{filename}" "#{opts}" />
    EOF
  end

  private
  def with_digest(filename)
    hexdigest = sha1_digest(File.join($rb_dir, filename))
    ext = File.extname filename
    sans_ext = filename.sub(/#{ext}$/, '')
   "#{sans_ext}.#{hexdigest}#{ext}"
  end

  def sha1_digest(filename)
    digest = Digest::MD5.new
    File.open(filename) do |f|
        digest.update f.read(8192) until f.eof
    end
    digest.hexdigest
  end
end

def load_yaml(filename)
  YAML.load_file(File.join($rb_dir, filename))
end


def gen_site(opts={})
  pretty = opts[:pretty]
  $prod = opts[:prod] || false
  Slim::Engine.set_default_options :pretty => pretty

  pages = private_methods.grep(/^page_/)
  pages.each do |page|
    page_name = page.to_s.sub('page_', '')
    filename = File.join($rb_dir, "#{page_name}.html")
    File.open(filename, 'w') {|f| f << send(page) }
  end
end

# Page definitions.

def page_index
  tenets = load_yaml('data/tenets.yml')['tenets']
  services = load_yaml('data/services.yml')['services']
  scope = Env.new(tenets: tenets, services: services, page_name: 'overview')
  scope.render('index.html.slim')
end

def page_code
  repos = load_yaml('data/repos.yml')['repos'].sort_by {|repo| repo['header'].downcase }
  scope = Env.new(repos: repos, page_name: 'code')
  scope.render('code.html.slim')
end

def page_how
  hows = load_yaml('data/hows.yml')['hows']
  scope = Env.new(hows: hows, page_name: 'how')
  scope.render('how.html.slim')
end

def page_who
  scope = Env.new(page_name: 'who')
  scope.render('who.html.slim')
end

def page_contact
  scope = Env.new(page_name: 'contact')
  scope.render('contact.html.slim')
end

gen_site(pretty: true) if __FILE__ == $0
