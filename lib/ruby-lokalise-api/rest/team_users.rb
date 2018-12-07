module Lokalise
  class Client
    def team_users(team_id, params = {})
      Lokalise::Collections::TeamUser.all self, params, team_id
    end

    def team_user(team_id, user_id)
      Lokalise::Resources::TeamUser.find self, team_id, user_id
    end

    def update_team_user(team_id, user_id, params)
      Lokalise::Resources::TeamUser.update self, team_id, user_id, params
    end

    def delete_team_user(team_id, user_id)
      Lokalise::Resources::TeamUser.destroy self, team_id, user_id
    end
  end
end
