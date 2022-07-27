# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module TeamUsers
      # Returns all team users for the given team
      #
      # @see https://developers.lokalise.com/reference/list-all-team-users
      # @return [RubyLokaliseApi::Collection::TeamUser<RubyLokaliseApi::Resources::TeamUser>]
      # @param team_id [String]
      # @param params [Hash]
      def team_users(team_id, params = {})
        c_r RubyLokaliseApi::Collections::TeamUser, :all, team_id, params
      end

      # Returns team user from the given team
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-team-user
      # @return [RubyLokaliseApi::Resources::TeamUser]
      # @param team_id [String]
      # @param user_id [String, Integer]
      def team_user(team_id, user_id)
        c_r RubyLokaliseApi::Resources::TeamUser, :find, [team_id, user_id]
      end

      # Updates team user for the given team
      #
      # @see https://developers.lokalise.com/reference/update-a-team-user
      # @return [RubyLokaliseApi::Resources::TeamUser]
      # @param team_id [String]
      # @param user_id [String, Integer]
      # @param params [Hash]
      def update_team_user(team_id, user_id, params)
        c_r RubyLokaliseApi::Resources::TeamUser, :update, [team_id, user_id], params
      end

      # Deletes team user from the given team
      #
      # @see https://developers.lokalise.com/reference/delete-a-team-user
      # @return [RubyLokaliseApi::Resources::TeamUser]
      # @param team_id [String]
      # @param user_id [String, Integer]
      def destroy_team_user(team_id, user_id)
        c_r RubyLokaliseApi::Resources::TeamUser, :destroy, [team_id, user_id]
      end
    end
  end
end
