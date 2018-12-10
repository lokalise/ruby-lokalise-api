module Lokalise
  class Client
    # Returns all team users for the given team
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-team-users-get
    # @return [Lokalise::Collection::TeamUser<Lokalise::Resources::TeamUser>]
    # @param team_id [String]
    # @param params [Hash]
    def team_users(team_id, params = {})
      Lokalise::Collections::TeamUser.all self, params, team_id
    end

    # Returns team user from the given team
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-team-user-get
    # @return [Lokalise::Resources::TeamUser]
    # @param team_id [String]
    # @param user_id [String, Integer]
    def team_user(team_id, user_id)
      Lokalise::Resources::TeamUser.find self, team_id, user_id
    end

    # Updates team user for the given team
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-team-user-put
    # @return [Lokalise::Resources::TeamUser]
    # @param team_id [String]
    # @param user_id [String, Integer]
    # @param params [Hash]
    def update_team_user(team_id, user_id, params)
      Lokalise::Resources::TeamUser.update self, team_id, user_id, params
    end

    # Deletes team user from the given team
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-team-user-delete
    # @return [Lokalise::Resources::TeamUser]
    # @param team_id [String]
    # @param user_id [String, Integer]
    def delete_team_user(team_id, user_id)
      Lokalise::Resources::TeamUser.destroy self, team_id, user_id
    end
  end
end
