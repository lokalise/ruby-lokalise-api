module Lokalise
  class Client
    def team_users(team_id, params = {})
      Lokalise::Collections::TeamUser.all @token, params.merge(id: team_id)
    end

    def team_user(team_id, user_id)
      Lokalise::Resources::TeamUser.find @token, team_id, user_id
    end

    def update_team_user(team_id, user_id, params)
      Lokalise::Resources::TeamUser.update @token, team_id, user_id, params
    end

    def delete_team_user(team_id, user_id)
      Lokalise::Resources::TeamUser.destroy @token, team_id, user_id
    end
  end
end
