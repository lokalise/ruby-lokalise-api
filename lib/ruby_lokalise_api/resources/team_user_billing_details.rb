# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class TeamUserBillingDetails < Base
      class << self
        def endpoint(team_id)
          path_from teams: team_id,
                    billing_details: ''
        end
      end
    end
  end
end
