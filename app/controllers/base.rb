require_relative '../lib/view'

class Base
  DEFAULT_LAYOUT = 'app/views/layout.slim'

  def render(template_name, scope, layout = nil)
    View.new(scope).render(template_name, layout)
  end
end
