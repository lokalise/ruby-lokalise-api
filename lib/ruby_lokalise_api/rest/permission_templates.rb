# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module PermissionTemplates
      # Returns permission tempates for a team
      #
      # @see https://developers.lokalise.com/reference/list-all-permission-templates
      # @return [RubyLokaliseApi::Collections::PermissionTemplates]
      # @param team_id [Integer, String]
      def permission_templates(team_id)
        name = 'PermissionTemplates'
        params = { query: team_id }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end
    end
  end
end
