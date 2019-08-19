module Lokalise
  class Client
    # Returns all webhooks for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-webhooks-get
    # @return [Lokalise::Collection::Webhook<Lokalise::Resources::Webhook>]
    # @param project_id [String]
    # @param params [Hash]
    def webhooks(project_id, params = {})
      c_r Lokalise::Collections::Webhook, :all, project_id, params
    end

    # Returns a single webhook for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-webhook-get
    # @return [Lokalise::Resources::Webhook]
    # @param project_id [String]
    # @param webhook_id [String, Integer]
    def webhook(project_id, webhook_id)
      c_r Lokalise::Resources::Webhook, :find, [project_id, webhook_id]
    end

    # Creates webhook for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-create-a-webhook-post
    # @return [Lokalise::Resources::Webhook]
    # @param project_id [String]
    # @param params [Hash]
    def create_webhook(project_id, params)
      c_r Lokalise::Resources::Webhook, :create, project_id, params
    end

    # Updates webhook for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-webhook-put
    # @return [Lokalise::Resources::Webhook]
    # @param project_id [String]
    # @param webhook_id [String, Integer]
    # @param params [Hash]
    def update_webhook(project_id, webhook_id, params = {})
      c_r Lokalise::Resources::Webhook, :update, [project_id, webhook_id], params
    end

    # Deletes webhook for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-webhook-delete
    # @return [Hash]
    # @param project_id [String]
    # @param webhook_id [String, Integer]
    def destroy_webhook(project_id, webhook_id)
      c_r Lokalise::Resources::Webhook, :destroy, [project_id, webhook_id]
    end
  end
end
