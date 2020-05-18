# frozen_string_literal: true

module Lokalise
  class Client
    # Returns all teams available to the user
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-list-all-teams-get
    # @return [Lokalise::Collection::Team<Lokalise::Resources::Team>]
    # @param params [Hash]
    def teams(params = {})
      c_r Lokalise::Collections::Team, :all, nil, params
    end
  end
end
