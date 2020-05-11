# frozen_string_literal: true

module Lokalise
  module Resources
    class Webhook < Base
      supports :update, :destroy, [:reload_data, '', :find]

      def regenerate_secret
        self.class.regenerate_secret @client, @path + '/secret/regenerate'
      end

      class << self
        def regenerate_secret(client, path, *_args)
          patch(path, client)['content']
        end

        def endpoint(project_id, webhook_id = nil, *actions)
          path_from projects: project_id,
                    webhooks: [webhook_id, *actions]
        end
      end
    end
  end
end
