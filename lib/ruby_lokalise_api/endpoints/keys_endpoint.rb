# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class KeysEndpoint < MainEndpoint
      private

      def base_query(project_id, key_id = nil)
        {
          projects: project_id,
          keys: key_id
        }
      end
    end
  end
end
