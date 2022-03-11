# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module TeamUserBillingDetails
      # Returns team user billing details
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-retrieve-team-user-billing-details-get
      # @return [RubyLokaliseApi::Resources::TeamUserBillingDetails]
      # @param team_id [String]
      def team_user_billing_details(team_id)
        c_r RubyLokaliseApi::Resources::TeamUserBillingDetails, :find, team_id
      end

      # Creates team user billing details
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-create-team-user-billing-details-post
      # @return [RubyLokaliseApi::Resources::TeamUserBillingDetails]
      # @param team_id [String]
      # @param params [Hash]
      def create_team_user_billing_details(team_id, params)
        c_r RubyLokaliseApi::Resources::TeamUserBillingDetails, :create, team_id, params
      end

      # Updates team user billing details
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-create-team-user-billing-details-post
      # @return [RubyLokaliseApi::Resources::TeamUserBillingDetails]
      # @param team_id [String]
      # @param params [Hash]
      def update_team_user_billing_details(team_id, params)
        c_r RubyLokaliseApi::Resources::TeamUserBillingDetails, :update, team_id, params
      end
    end
  end
end
