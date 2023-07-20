# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Webhooks < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::WebhooksEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Webhook
    end
  end
end
