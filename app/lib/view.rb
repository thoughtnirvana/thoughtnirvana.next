require 'slim'
require_relative '../../config/environment'

class View
  def initialize(scope = {}, prod = false)
    @prod = prod
    scope.each { |k, v| define_singleton_method(k, proc { v }) }
  end

  def render(template, layout = nil, options={}, &block)
    contents = Slim::Template.new(template, options).render(self, &block)
    if layout
      contents = Slim::Template.new(layout, options).render(self) { contents }
    end
    contents
  end

  def stylesheet_link_tag(filename)
    <<-CSS
    <link href="#{assets_path filename}" rel="stylesheet" type="text/css" />
    CSS
  end

  def javascript_include_tag(filename)
    <<-JS
    <script src="#{assets_path filename}" type="text/javascript"></script>
    JS
  end

  def image_tag(filename, opts = {})
    opts = opts.reduce('') { |accum, (k, v)| "#{accum} #{k}=\"#{v}\"" }
    <<-IMG
    <img src="#{assets_path filename}" "#{opts}" />
    IMG
  end

  def assets_path(filename)
    assets_root = Environment.config.assets_output_dir
    assets_file_name = Environment.config.assets_manifest.assets[filename]
    "/#{assets_root}/#{assets_file_name}"
  end
end
