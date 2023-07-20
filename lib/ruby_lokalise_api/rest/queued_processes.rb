# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module QueuedProcesses
      # Returns a single queued process
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-process
      # @return [RubyLokaliseApi::Resources::QueuedProcess]
      # @param project_id [String]
      # @param process_id [String, Integer]
      def queued_process(project_id, process_id)
        params = { query: [project_id, process_id] }

        data = endpoint(name: 'QueuedProcesses', params: params).do_get

        resource 'QueuedProcess', data
      end

      # Returns queued processes
      #
      # @see https://developers.lokalise.com/reference/list-all-processes
      # @return [RubyLokaliseApi::Collections::QueuedProcesses]
      # @param project_id [String]
      # @param req_params [Hash]
      def queued_processes(project_id, req_params = {})
        name = 'QueuedProcesses'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end
    end
  end
end
