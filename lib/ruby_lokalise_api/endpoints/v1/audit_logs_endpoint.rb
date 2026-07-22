# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    module V1
      class AuditLogsEndpoint < MainEndpoint
        private

        def base_query(class_uuid = nil, *_args)
          {
            'audit-logs': [class_uuid]
          }
        end
      end
    end
  end
end
