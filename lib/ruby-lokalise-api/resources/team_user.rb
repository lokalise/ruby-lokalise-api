# frozen_string_literal: true

module Lokalise
  module Resources
    class TeamUser < Base
      ID_KEY = 'user'
      supports :update, :destroy, [:reload_data, '', :find]

      class << self
        def endpoint(team_id, team_user_id = nil)
          path_from teams: team_id,
                    users: team_user_id
        end
      end
    end
  end
end
