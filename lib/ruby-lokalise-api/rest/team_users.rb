# frozen_string_literal: true

module Lokalise
  class Client
    # Returns all team users for the given team
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-team-users-get
    # @return [Lokalise::Collection::TeamUser<Lokalise::Resources::TeamUser>]
    # @param team_id [String]
    # @param params [Hash]
    def team_users(team_id, params = {})
      c_r Lokalise::Collections::TeamUser, :all, team_id, params
    end

    # Returns team user from the given team
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-team-user-get
    # @return [Lokalise::Resources::TeamUser]
    # @param team_id [String]
    # @param user_id [String, Integer]
    def team_user(team_id, user_id)
      c_r Lokalise::Resources::TeamUser, :find, [team_id, user_id]
    end

    # Updates team user for the given team
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-team-user-put
    # @return [Lokalise::Resources::TeamUser]
    # @param team_id [String]
    # @param user_id [String, Integer]
    # @param params [Hash]
    def update_team_user(team_id, user_id, params)
      c_r Lokalise::Resources::TeamUser, :update, [team_id, user_id], params
    end

    # Deletes team user from the given team
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-team-user-delete
    # @return [Lokalise::Resources::TeamUser]
    # @param team_id [String]
    # @param user_id [String, Integer]
    def destroy_team_user(team_id, user_id)
      c_r Lokalise::Resources::TeamUser, :destroy, [team_id, user_id]
    end
  end
end
