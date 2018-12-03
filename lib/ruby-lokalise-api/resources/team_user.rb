module Lokalise
  module Resources
    class TeamUser < Base
      class << self
        private

        def endpoint(team_id)
          "teams/#{team_id}/users"
        end
      end
    end
  end
end
