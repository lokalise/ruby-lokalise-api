# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Teams
      # Returns all teams available to the user
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-list-all-teams-get
      # @return [RubyLokaliseApi::Collection::Team<RubyLokaliseApi::Resources::Team>]
      # @param params [Hash]
      def teams(params = {})
        c_r RubyLokaliseApi::Collections::Team, :all, nil, params
      end
    end
  end
end
