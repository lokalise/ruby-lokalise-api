module Lokalise
  class Client
    # Returns all team user groups for the given team
    #
    # @see https://lokalise.co/api2docs/curl/#transition-list-all-groups-get
    # @return [Lokalise::Collection::TeamUserGroup<Lokalise::Resources::TeamUserGroup>]
    # @param team_id [String]
    # @param params [Hash]
    def team_user_groups(team_id, params = {})
      c_r Lokalise::Collections::TeamUserGroup, :all, team_id, params
    end

    # Returns team user from the given team
    #
    # @see https://lokalise.co/api2docs/curl/#transition-retrieve-a-group-get
    # @return [Lokalise::Resources::TeamUserGroup]
    # @param team_id [String]
    # @param group_id [String, Integer]
    def team_user_group(team_id, group_id)
      c_r Lokalise::Resources::TeamUserGroup, :find, [team_id, group_id]
    end

    # Creates team user group
    #
    # @see https://lokalise.co/api2docs/curl/#resource-team-user-groups
    # @return [Lokalise::Resources::TeamUserGroup]
    # @param params [Hash]
    def create_team_user_group(team_id, params)
      c_r Lokalise::Resources::TeamUserGroup, :create, team_id, params
    end

    # Updates team user group for the given team
    #
    # @see https://lokalise.co/api2docs/curl/#transition-update-a-group-put
    # @return [Lokalise::Resources::TeamUserGroup]
    # @param team_id [String]
    # @param group_id [String, Integer]
    # @param params [Hash]
    def update_team_user_group(team_id, group_id, params)
      c_r Lokalise::Resources::TeamUserGroup, :update, [team_id, group_id], params
    end

    # Deletes team user group from the given team
    #
    # @see https://lokalise.co/api2docs/curl/#transition-delete-a-group-delete
    # @return [Lokalise::Resources::TeamUserGroup]
    # @param team_id [String]
    # @param group_id [String, Integer]
    def destroy_team_user_group(team_id, group_id)
      c_r Lokalise::Resources::TeamUserGroup, :destroy, [team_id, group_id]
    end

    # Adds projects to the given group
    #
    # @see https://lokalise.co/api2docs/curl/#transition-add-projects-to-group-put
    # @return [Lokalise::Resources::TeamUserGroup]
    # @param team_id [String]
    # @param group_id [String, Integer]
    # @param project_ids [String, Integer, Array<String>, Array<Integer>]
    def add_projects_to_group(team_id, group_id, project_ids)
      c_r Lokalise::Resources::TeamUserGroup, :update,
          [team_id, group_id, 'projects', 'add'],
          project_ids, :projects
    end

    # Removes projects from the given group
    #
    # @see https://lokalise.co/api2docs/curl/#transition-remove-projects-from-group-put
    # @return [Lokalise::Resources::TeamUserGroup]
    # @param team_id [String]
    # @param group_id [String, Integer]
    # @param project_ids [String, Integer, Array<String>, Array<Integer>]
    def remove_projects_from_group(team_id, group_id, project_ids)
      c_r Lokalise::Resources::TeamUserGroup, :update,
          [team_id, group_id, 'projects', 'remove'],
          project_ids, :projects
    end

    # Adds users to the given group
    #
    # @see https://lokalise.co/api2docs/curl/#transition-add-members-to-group-put
    # @return [Lokalise::Resources::TeamUserGroup]
    # @param team_id [String]
    # @param group_id [String, Integer]
    # @param users_ids [String, Integer, Array<String>, Array<Integer>]
    def add_users_to_group(team_id, group_id, users_ids)
      c_r Lokalise::Resources::TeamUserGroup, :update,
          [team_id, group_id, 'members', 'add'],
          users_ids, :users
    end

    # Removes users from the given group
    #
    # @see https://lokalise.co/api2docs/curl/#transition-remove-members-from-group-put
    # @return [Lokalise::Resources::TeamUserGroup]
    # @param team_id [String]
    # @param group_id [String, Integer]
    # @param users_ids [String, Integer, Array<String>, Array<Integer>]
    def remove_users_from_group(team_id, group_id, users_ids)
      c_r Lokalise::Resources::TeamUserGroup, :update,
          [team_id, group_id, 'members', 'remove'],
          users_ids, :users
    end
  end
end
