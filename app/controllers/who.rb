require_relative './base'

class Who < Base
  def render
    scope = {
      page_name: 'who'
    }
    super('app/views/who.slim', scope, DEFAULT_LAYOUT)
  end
end
