# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class WebhooksEndpoint < MainEndpoint
      private

      def base_query(project_id, webhook_id = nil, *actions)
        {
          projects: project_id,
          webhooks: [webhook_id, actions]
        }
      end
    end
  end
end
