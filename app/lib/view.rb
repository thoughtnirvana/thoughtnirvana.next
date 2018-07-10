require 'slim'

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

  def link_tag(filename, rel, type)
    filename = with_digest(filename) if @prod
    <<-LINK
    <link href="#{filename}" rel="#{rel}" type="#{type}" />
    LINK
  end

  def css_tag(filename)
    link_tag(filename, 'stylesheet', 'text/css')
  end

  def less_tag(filename)
    link_tag(filename, 'stylesheet/less', 'text/css')
  end

  def js_tag(filename)
    filename = with_digest(filename) if @prod
    <<-JS
    <script src="#{filename}" type="text/javascript"></script>
    JS
  end

  def img_tag(filename, opts = {})
    opts = opts.reduce('') { |accum, (k, v)| "#{accum} #{k}=\"#{v}\"" }
    filename = with_digest(filename) if @prod
    <<-IMG
    <img src="#{filename}" "#{opts}" />
    IMG
  end

  private

  def with_digest(filename)
    hexdigest = sha1_digest(filename)
    ext = File.extname filename
    sans_ext = filename.sub(/#{ext}$/, '')
    "#{sans_ext}.#{hexdigest}#{ext}"
  end

  def sha1_digest(filename)
    digest = Digest::MD5.new
    File.open(filename) do |file|
      digest.update file.read(8192) until file.eof
    end
    digest.hexdigest
  end
end
