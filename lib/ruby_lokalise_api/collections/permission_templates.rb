# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class PermissionTemplates < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::PermissionTemplatesEndpoint
      RESOURCE = RubyLokaliseApi::Resources::PermissionTemplate
      DATA_KEY = 'roles'
    end
  end
end
