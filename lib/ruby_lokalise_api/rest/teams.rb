# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Teams
      # Returns teams
      #
      # @see https://developers.lokalise.com/reference/list-all-teams
      # @return [RubyLokaliseApi::Collections::Teams]
      # @param req_params [Hash]
      def teams(req_params = {})
        name = 'Teams'
        params = { req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single team
      #
      # @see https://developers.lokalise.com/reference/get-team-details
      # @return [RubyLokaliseApi::Resources::Team]
      # @param team_id [String, Integer]
      def team(team_id)
        params = { query: team_id }

        data = endpoint(name: 'Teams', params: params).do_get

        resource 'Team', data
      end
    end
  end
end
