# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Snapshots
      # Returns project snapshots
      #
      # @see https://developers.lokalise.com/reference/list-all-snapshots
      # @return [RubyLokaliseApi::Collections::Snapshots]
      # @param project_id [String]
      # @param req_params [Hash]
      def snapshots(project_id, req_params = {})
        name = 'Snapshots'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Creates a snapshot
      #
      # @see https://developers.lokalise.com/reference/create-a-snapshot
      # @return [RubyLokaliseApi::Resources::Snapshot]
      # @param project_id [String]
      # @param req_params [Hash]
      def create_snapshot(project_id, req_params = {})
        params = { query: project_id, req: req_params }

        data = endpoint(name: 'Snapshots', params: params).do_post

        resource 'Snapshot', data
      end

      # Restores a snapshot by creating a project copy
      #
      # @see https://developers.lokalise.com/reference/restore-a-snapshot
      # @return [RubyLokaliseApi::Resources::Project]
      # @param project_id [String]
      # @param snapshot_id [String, Integer]
      def restore_snapshot(project_id, snapshot_id)
        params = { query: [project_id, snapshot_id] }

        response = endpoint(name: 'Snapshots', params: params).do_post

        # We restore a project so its endpoint is different
        response.patch_endpoint_with endpoint(name: 'Projects', params: { query: [project_id] })

        resource 'Project', response
      end

      # Deletes a snapshot
      #
      # @see https://developers.lokalise.com/reference/delete-a-snapshot
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param snapshot_id [String, Integer]
      def destroy_snapshot(project_id, snapshot_id)
        params = { query: [project_id, snapshot_id] }

        data = endpoint(name: 'Snapshots', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end
