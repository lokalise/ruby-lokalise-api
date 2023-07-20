# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module TeamUserGroups
      using RubyLokaliseApi::Utils::Classes

      # Returns team user groups
      #
      # @see https://developers.lokalise.com/reference/list-all-groups
      # @return [RubyLokaliseApi::Collections::TeamUserGroups]
      # @param team_id [Integer, String]
      # @param req_params [Hash]
      def team_user_groups(team_id, req_params = {})
        name = 'TeamUserGroups'
        params = { query: team_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single team user group
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String, Integer]
      # @param group_id [String, Integer]
      def team_user_group(team_id, group_id)
        params = { query: [team_id, group_id] }

        response = endpoint(name: 'TeamUserGroups', params: params).do_get

        resource 'TeamUserGroup', response
      end

      # Creates a team user group
      #
      # @see https://developers.lokalise.com/reference/create-a-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String, Integer]
      # @param req_params [Hash]
      def create_team_user_group(team_id, req_params)
        params = { query: team_id, req: req_params }

        response = endpoint(name: 'TeamUserGroups', params: params).do_post

        resource 'TeamUserGroup', response
      end

      # Updates a team user group
      #
      # @see https://developers.lokalise.com/reference/update-a-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String, Integer]
      # @param group_id [String, Integer]
      # @param req_params [Hash]
      def update_team_user_group(team_id, group_id, req_params = {})
        params = { query: [team_id, group_id], req: req_params }

        data = endpoint(name: 'TeamUserGroups', params: params).do_put

        resource 'TeamUserGroup', data
      end

      # Deletes a team user group
      #
      # @see https://developers.lokalise.com/reference/delete-a-group
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param team_id [String, Integer]
      # @param group_id [String, Integer]
      def destroy_team_user_group(team_id, group_id)
        params = { query: [team_id, group_id] }

        data = endpoint(name: 'TeamUserGroups', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end

      # Adds projects to the group
      #
      # @see https://developers.lokalise.com/reference/add-projects-to-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String, Integer]
      # @param group_id [String, Integer]
      # @param project_ids [Array, String]
      def add_projects_to_group(team_id, group_id, project_ids)
        params = { query: [team_id, group_id, :projects, :add], req: project_ids.to_array_obj(:projects) }

        data = endpoint(name: 'TeamUserGroups', params: params).do_put

        resource 'TeamUserGroup', data
      end

      # Removes projects from the group
      #
      # @see https://developers.lokalise.com/reference/remove-projects-from-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String, Integer]
      # @param group_id [String, Integer]
      # @param project_ids [Array, String]
      def remove_projects_from_group(team_id, group_id, project_ids)
        params = { query: [team_id, group_id, :projects, :remove], req: project_ids.to_array_obj(:projects) }

        data = endpoint(name: 'TeamUserGroups', params: params).do_put

        resource 'TeamUserGroup', data
      end

      # Adds members to the group
      #
      # @see https://developers.lokalise.com/reference/add-members-to-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String, Integer]
      # @param group_id [String, Integer]
      # @param user_ids [Array, String]
      def add_members_to_group(team_id, group_id, user_ids)
        params = { query: [team_id, group_id, :members, :add], req: user_ids.to_array_obj(:users) }

        data = endpoint(name: 'TeamUserGroups', params: params).do_put

        resource 'TeamUserGroup', data
      end

      # Removes members from the group
      #
      # @see https://developers.lokalise.com/reference/remove-members-from-group
      # @return [RubyLokaliseApi::Resources::TeamUserGroup]
      # @param team_id [String, Integer]
      # @param group_id [String, Integer]
      # @param user_ids [Array, String]
      def remove_members_from_group(team_id, group_id, user_ids)
        params = { query: [team_id, group_id, :members, :remove], req: user_ids.to_array_obj(:users) }

        data = endpoint(name: 'TeamUserGroups', params: params).do_put

        resource 'TeamUserGroup', data
      end
    end
  end
end
