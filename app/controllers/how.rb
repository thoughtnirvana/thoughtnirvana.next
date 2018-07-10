require_relative './base'
require_relative '../models/hows'

class How < Base
  def render
    scope = {
      hows: Hows.all,
      page_name: 'how'
    }
    super('app/views/how.slim', scope, DEFAULT_LAYOUT)
  end
end
