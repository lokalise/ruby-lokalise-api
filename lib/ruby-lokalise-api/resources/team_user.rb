module Lokalise
  module Resources
    class TeamUser < Base
      class << self
        def endpoint(team_id, team_user_id = nil)
          path_from teams: team_id,
                    users: team_user_id
        end
      end
    end
  end
end
