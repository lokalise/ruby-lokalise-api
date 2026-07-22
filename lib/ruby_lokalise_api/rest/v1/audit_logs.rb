# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module V1
      module AuditLogs
        # Returns audit logs
        #
        # @see https://developers.lokalise.com/reference/list-audit-logs
        # @return [RubyLokaliseApi::Collections::V1::AuditLogs]
        # @param req_params [Hash]
        def audit_logs(req_params = {})
          name = 'V1::AuditLogs'
          params = { req: req_params }

          data = endpoint(name: name, params: params).do_get

          collection name, data
        end
      end
    end
  end
end
