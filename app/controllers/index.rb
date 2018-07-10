require_relative './base'
require_relative '../models/tenets'
require_relative '../models/services'

class Index < Base
  def render
    scope = {
      tenets: Tenets.all,
      services: Services.all,
      page_name: 'overview'
    }
    super('app/views/index.slim', scope, DEFAULT_LAYOUT)
  end
end
