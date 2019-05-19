module Lokalise
  module Resources
    class TeamUserGroup < Base
      DATA_KEY = 'Group'.freeze
      ID_KEY = 'group'.freeze
      supports :update, :destroy,
               [:add_projects, '/projects/add', :update],
               [:remove_projects, '/projects/remove', :update],
               [:add_users, '/members/add', :update],
               [:remove_users, '/members/remove', :update]

      class << self
        def endpoint(team_id, team_user_group_id = nil, *actions)
          path_from teams: team_id,
                    groups: [team_user_group_id, *actions]
        end
      end
    end
  end
end
