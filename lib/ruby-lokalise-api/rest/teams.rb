module Lokalise
  class Client
    # Returns all teams available to the user
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-teams-get
    # @return [Lokalise::Collection::Team<Lokalise::Resources::Team>]
    # @param params [Hash]
    def teams(params = {})
      Lokalise::Collections::Team.all self, params
    end
  end
end
