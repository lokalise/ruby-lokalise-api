# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module TeamUserGroups
      # Returns all team user groups for the given team
      #
      # @see https://developers.lokalise.com/reference/list-all-team-users
      # @return [RubyLokaliseApi::Collection::TeamUserGroup<RubyLokaliseApi::Resources::TeamUserGroup>]
      # @param team_id [String]
      # @param params [Hash]
      def team_user_groups(team_id, params = {})
        c_r RubyLokaliseApi::Collections::TeamUserGroup, :all, team_id, params
      end

      # Returns team user from the given team
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-team-user
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String]
      # @param group_id [String, Integer]
      def team_user_group(team_id, group_id)
        c_r RubyLokaliseApi::Resources::TeamUserGroup, :find, [team_id, group_id]
      end

      # Creates team user group
      #
      # @see https://developers.lokalise.com/reference/create-a-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param params [Hash]
      def create_team_user_group(team_id, params)
        c_r RubyLokaliseApi::Resources::TeamUserGroup, :create, team_id, params
      end

      # Updates team user group for the given team
      #
      # @see https://developers.lokalise.com/reference/update-a-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String]
      # @param group_id [String, Integer]
      # @param params [Hash]
      def update_team_user_group(team_id, group_id, params)
        c_r RubyLokaliseApi::Resources::TeamUserGroup, :update, [team_id, group_id], params
      end

      # Deletes team user group from the given team
      #
      # @see https://developers.lokalise.com/reference/delete-a-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String]
      # @param group_id [String, Integer]
      def destroy_team_user_group(team_id, group_id)
        c_r RubyLokaliseApi::Resources::TeamUserGroup, :destroy, [team_id, group_id]
      end

      # Adds projects to the given group
      #
      # @see https://developers.lokalise.com/reference/add-projects-to-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String]
      # @param group_id [String, Integer]
      # @param project_ids [String, Integer, Array<String>, Array<Integer>]
      def add_projects_to_group(team_id, group_id, project_ids)
        c_r RubyLokaliseApi::Resources::TeamUserGroup, :update,
            [team_id, group_id, 'projects', 'add'],
            project_ids, :projects, [team_id, group_id]
      end

      # Removes projects from the given group
      #
      # @see https://developers.lokalise.com/reference/remove-projects-from-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String]
      # @param group_id [String, Integer]
      # @param project_ids [String, Integer, Array<String>, Array<Integer>]
      def remove_projects_from_group(team_id, group_id, project_ids)
        c_r RubyLokaliseApi::Resources::TeamUserGroup, :update,
            [team_id, group_id, 'projects', 'remove'],
            project_ids, :projects, [team_id, group_id]
      end

      # Adds users to the given group
      #
      # @see https://developers.lokalise.com/reference/add-members-to-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String]
      # @param group_id [String, Integer]
      # @param users_ids [String, Integer, Array<String>, Array<Integer>]
      def add_users_to_group(team_id, group_id, users_ids)
        c_r RubyLokaliseApi::Resources::TeamUserGroup, :update,
            [team_id, group_id, 'members', 'add'],
            users_ids, :users, [team_id, group_id]
      end

      # Removes users from the given group
      #
      # @see https://developers.lokalise.com/reference/remove-members-from-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String]
      # @param group_id [String, Integer]
      # @param users_ids [String, Integer, Array<String>, Array<Integer>]
      def remove_users_from_group(team_id, group_id, users_ids)
        c_r RubyLokaliseApi::Resources::TeamUserGroup, :update,
            [team_id, group_id, 'members', 'remove'],
            users_ids, :users, [team_id, group_id]
      end
    end
  end
end
