# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class TeamUser < Base
      class << self
        def endpoint(team_id, *_args)
          path_from teams: [team_id, 'users']
        end
      end
    end
  end
end
