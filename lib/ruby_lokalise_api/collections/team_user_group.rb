# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class TeamUserGroup < Base
      DATA_KEY = 'UserGroup'

      class << self
        def endpoint(team_id, *_args)
          path_from teams: [team_id, 'groups']
        end
      end
    end
  end
end
