# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Webhooks
      # Returns all webhooks for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-list-all-webhooks-get
      # @return [RubyLokaliseApi::Collection::Webhook<RubyLokaliseApi::Resources::Webhook>]
      # @param project_id [String]
      # @param params [Hash]
      def webhooks(project_id, params = {})
        c_r RubyLokaliseApi::Collections::Webhook, :all, project_id, params
      end

      # Returns a single webhook for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-retrieve-a-webhook-get
      # @return [RubyLokaliseApi::Resources::Webhook]
      # @param project_id [String]
      # @param webhook_id [String, Integer]
      def webhook(project_id, webhook_id)
        c_r RubyLokaliseApi::Resources::Webhook, :find, [project_id, webhook_id]
      end

      # Creates webhook for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-create-a-webhook-post
      # @return [RubyLokaliseApi::Resources::Webhook]
      # @param project_id [String]
      # @param params [Hash]
      def create_webhook(project_id, params)
        c_r RubyLokaliseApi::Resources::Webhook, :create, project_id, params
      end

      # Updates webhook for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-update-a-webhook-put
      # @return [RubyLokaliseApi::Resources::Webhook]
      # @param project_id [String]
      # @param webhook_id [String, Integer]
      # @param params [Hash]
      def update_webhook(project_id, webhook_id, params = {})
        c_r RubyLokaliseApi::Resources::Webhook, :update, [project_id, webhook_id], params
      end

      # Deletes webhook for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-delete-a-webhook-delete
      # @return [Hash]
      # @param project_id [String]
      # @param webhook_id [String, Integer]
      def destroy_webhook(project_id, webhook_id)
        c_r RubyLokaliseApi::Resources::Webhook, :destroy, [project_id, webhook_id]
      end

      # Regenerates secret for the given webhook
      #
      # @see https://lokalise.com/api2docs/curl/#transition-regenerate-a-webhook-secret-patch
      # @return [Hash]
      # @param project_id [String]
      # @param webhook_id [String, Integer]
      def regenerate_webhook_secret(project_id, webhook_id)
        c_r RubyLokaliseApi::Resources::Webhook, :regenerate_secret,
            [project_id, webhook_id, 'secret', 'regenerate']
      end
    end
  end
end
