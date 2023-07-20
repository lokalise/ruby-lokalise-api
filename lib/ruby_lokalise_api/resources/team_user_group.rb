# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class TeamUserGroup < Base
      MAIN_PARAMS = %i[team_id group_id].freeze
      DATA_KEY = 'group'

      delegate_call :add_projects, :add_projects_to_group
      delegate_call :remove_projects, :remove_projects_from_group
      delegate_call :add_members, :add_members_to_group
      delegate_call :remove_members, :remove_members_from_group
    end
  end
end
