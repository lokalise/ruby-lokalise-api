# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    module V1
      class AuditLogs < Base
        ENDPOINT = RubyLokaliseApi::Endpoints::V1::AuditLogsEndpoint
        RESOURCE = RubyLokaliseApi::Resources::V1::AuditLog
        DATA_KEY = 'data'
      end
    end
  end
end
