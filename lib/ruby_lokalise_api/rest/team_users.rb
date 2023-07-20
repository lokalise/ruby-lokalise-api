# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module TeamUsers
      # Returns team users
      #
      # @see https://developers.lokalise.com/reference/list-all-team-users
      # @return [RubyLokaliseApi::Collections::TeamUsers]
      # @param team_id [Integer, String]
      # @param req_params [Hash]
      def team_users(team_id, req_params = {})
        name = 'TeamUsers'
        params = { query: team_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single team user
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-team-user
      # @return [RubyLokaliseApi::Resources::TeamUser]
      # @param team_id [String, Integer]
      # @param user_id [String, Integer]
      def team_user(team_id, user_id)
        params = { query: [team_id, user_id] }

        response = endpoint(name: 'TeamUsers', params: params).do_get

        resource 'TeamUser', response
      end

      # Updates a team user
      #
      # @see https://developers.lokalise.com/reference/update-a-team-user
      # @return [RubyLokaliseApi::Resources::TeamUser]
      # @param team_id [String, Integer]
      # @param user_id [String, Integer]
      # @param req_params [Hash]
      def update_team_user(team_id, user_id, req_params = {})
        params = { query: [team_id, user_id], req: req_params }

        data = endpoint(name: 'TeamUsers', params: params).do_put

        resource 'TeamUser', data
      end

      # Deletes a team user
      #
      # @see https://developers.lokalise.com/reference/delete-a-team-user
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param team_id [String, Integer]
      # @param user_id [String, Integer]
      def destroy_team_user(team_id, user_id)
        params = { query: [team_id, user_id] }

        data = endpoint(name: 'TeamUsers', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end
