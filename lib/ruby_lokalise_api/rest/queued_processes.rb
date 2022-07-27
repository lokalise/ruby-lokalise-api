# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module QueuedProcesses
      # Returns all queued processes for the given project
      #
      # @see https://developers.lokalise.com/reference/list-all-processes
      # @return [RubyLokaliseApi::Collection::QueuedProcess<RubyLokaliseApi::Resources::QueuedProcess>]
      # @param project_id [String]
      # @param params [Hash]
      def queued_processes(project_id, params = {})
        c_r RubyLokaliseApi::Collections::QueuedProcess, :all, project_id, params
      end

      # Returns a queued process for the given project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-process
      # @return [RubyLokaliseApi::Resources::QueuedProcess]
      # @param project_id [String]
      # @param process_id [String]
      def queued_process(project_id, process_id)
        c_r RubyLokaliseApi::Resources::QueuedProcess, :find,
            [project_id, process_id]
      end
    end
  end
end
