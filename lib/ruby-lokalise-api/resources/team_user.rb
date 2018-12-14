module Lokalise
  module Resources
    class TeamUser < Base
      ID_KEY = 'user'.freeze
      supports :update, :destroy

      class << self
        def endpoint(team_id, team_user_id = nil)
          path_from teams: team_id,
                    users: team_user_id
        end
      end
    end
  end
end
