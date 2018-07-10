require_relative './base'
require_relative '../models/repos'

class Code < Base
  def render
    scope = {
      repos: Repos.all.sort_by {|repo| repo['header'].downcase },
      page_name: 'code'
    }
    super('app/views/code.slim', scope, DEFAULT_LAYOUT)
  end
end
