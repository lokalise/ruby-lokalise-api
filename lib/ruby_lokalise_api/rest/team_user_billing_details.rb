# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module TeamUserBillingDetails
      # Returns billing details for a team user
      #
      # @see https://developers.lokalise.com/reference/retrieve-team-user-billing-details
      # @return [RubyLokaliseApi::Resources::TeamUserBillingDetails]
      # @param team_id [String, Integer]
      def team_user_billing_details(team_id)
        params = { query: team_id }

        response = endpoint(name: 'TeamUserBillingDetails', params: params).do_get

        # We must patch content because the API does not return team_id and it's mandatory to build resource URLs
        response.patch_content_with 'team_id', team_id

        resource 'TeamUserBillingDetails', response
      end

      # Creates team user billing details
      #
      # @see https://developers.lokalise.com/reference/create-team-user-billing-details
      # @return [RubyLokaliseApi::Resources::TeamUserBillingDetails]
      # @param team_id [String, Integer]
      # @param req_params [Hash, Array]
      def create_team_user_billing_details(team_id, req_params)
        params = { query: team_id, req: req_params }

        response = endpoint(name: 'TeamUserBillingDetails', params: params).do_post

        # We must patch content because the API does not return team_id and it's mandatory to build resource URL
        response.patch_content_with 'team_id', team_id

        resource 'TeamUserBillingDetails', response
      end

      # Updates team user billing details
      #
      # @see https://developers.lokalise.com/reference/update-team-user-billing-details
      # @return [RubyLokaliseApi::Resources::TeamUserBillingDetails]
      # @param team_id [String, Integer]
      # @param req_params [Hash]
      def update_team_user_billing_details(team_id, req_params = {})
        params = { query: team_id, req: req_params }

        data = endpoint(name: 'TeamUserBillingDetails', params: params).do_put

        # We must patch content because the API does not return team_id and it's mandatory to build resource URL
        data.patch_content_with 'team_id', team_id

        resource 'TeamUserBillingDetails', data
      end
    end
  end
end
