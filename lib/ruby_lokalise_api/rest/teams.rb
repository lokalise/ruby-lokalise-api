# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Teams
      # Returns all teams available to the user
      #
      # @see https://developers.lokalise.com/reference/list-all-teams
      # @return [RubyLokaliseApi::Collection::Team<RubyLokaliseApi::Resources::Team>]
      # @param params [Hash]
      def teams(params = {})
        c_r RubyLokaliseApi::Collections::Team, :all, nil, params
      end
    end
  end
end
