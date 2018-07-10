require_relative './base'

class Contact < Base
  def render
    scope = {
      page_name: 'contact'
    }
    super('app/views/contact.slim', scope, DEFAULT_LAYOUT)
  end
end
