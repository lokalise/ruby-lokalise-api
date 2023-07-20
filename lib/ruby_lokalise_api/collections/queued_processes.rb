# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class QueuedProcesses < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::QueuedProcessesEndpoint
      RESOURCE = RubyLokaliseApi::Resources::QueuedProcess
      DATA_KEY = 'processes'
    end
  end
end
