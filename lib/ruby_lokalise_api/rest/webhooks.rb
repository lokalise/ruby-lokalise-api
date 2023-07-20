# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Webhooks
      # Returns project webhooks
      #
      # @see https://developers.lokalise.com/reference/list-all-webhooks
      # @return [RubyLokaliseApi::Collections::Webhooks]
      # @param project_id [String]
      # @param req_params [Hash]
      def webhooks(project_id, req_params = {})
        name = 'Webhooks'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single webhook
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-webhook
      # @return [RubyLokaliseApi::Resources::Webhook]
      # @param project_id [String]
      # @param webhook_id [String]
      def webhook(project_id, webhook_id)
        params = { query: [project_id, webhook_id] }

        data = endpoint(name: 'Webhooks', params: params).do_get

        resource 'Webhook', data
      end

      # Creates a webhook
      #
      # @see https://developers.lokalise.com/reference/create-a-webhook
      # @return [RubyLokaliseApi::Resources::Webhook]
      # @param project_id [String]
      # @param req_params [Hash]
      def create_webhook(project_id, req_params)
        params = { query: project_id, req: req_params }

        data = endpoint(name: 'Webhooks', params: params).do_post

        resource 'Webhook', data
      end

      # Updates a webhook
      #
      # @see https://developers.lokalise.com/reference/update-a-webhook
      # @return [RubyLokaliseApi::Resources::Webhook]
      # @param project_id [String]
      # @param webhook_id [String]
      # @param req_params [Hash]
      def update_webhook(project_id, webhook_id, req_params)
        params = { query: [project_id, webhook_id], req: req_params }

        data = endpoint(name: 'Webhooks', params: params).do_put

        resource 'Webhook', data
      end

      # Regenerates webhook secret
      #
      # @see https://developers.lokalise.com/reference/regenerate-a-webhook-secret
      # @return [RubyLokaliseApi::Generics::RegeneratedWebhookSecret]
      # @param project_id [String]
      # @param webhook_id [String]
      def regenerate_webhook_secret(project_id, webhook_id)
        params = { query: [project_id, webhook_id, :secret, :regenerate] }

        data = endpoint(name: 'Webhooks', params: params).do_patch

        RubyLokaliseApi::Generics::RegeneratedWebhookSecret.new data.content
      end

      # Deletes a webhook
      #
      # @see https://developers.lokalise.com/reference/delete-a-webhook
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param webhook_id [String]
      def destroy_webhook(project_id, webhook_id)
        params = { query: [project_id, webhook_id] }

        data = endpoint(name: 'Webhooks', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end
