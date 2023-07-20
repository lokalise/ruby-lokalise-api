# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class TeamUserBillingDetails < Base
      MAIN_PARAMS = %i[team_id].freeze
      no_support_for %i[destroy]

      def update(params)
        response = reinit_endpoint(params).do_put

        # We must patch content because the API does not return team_id and it's mandatory to build resource URL
        response.patch_content_with 'team_id', @team_id

        self.class.new response
      end
    end
  end
end
