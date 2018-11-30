module Lokalise
  module Collections
    class TeamUser < Base
      class << self
        private

        def endpoint(team_id, *_args)
          "teams/#{team_id}/users"
        end
      end
    end
  end
end
