# frozen_string_literal: true

module RubyLokaliseApi
  module RestV1
    include Utils::Loaders

    include Rest::V1::AuditLogs
  end
end
