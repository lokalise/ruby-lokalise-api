module Lokalise
  module Resources
    class TeamUser < Base
      class << self
        def find(token, team_id, user_id)
          load_record endpoint(team_id), token, user_id
        end

        def update(token, team_id, user_id, params)
          update_record endpoint(team_id) + "/#{user_id}", token, params
        end

        def destroy(token, team_id, user_id)
          destroy_record endpoint(team_id), token, user_id
        end

        private

        def endpoint(team_id)
          "teams/#{team_id}/users"
        end
      end
    end
  end
end
