# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Snapshots
      # Returns all snapshots for the given project
      #
      # @see https://developers.lokalise.com/reference/list-all-snapshots
      # @return [RubyLokaliseApi::Collection::Snapshot<RubyLokaliseApi::Resources::Snapshot>]
      # @param project_id [String]
      # @param params [Hash]
      def snapshots(project_id, params = {})
        c_r RubyLokaliseApi::Collections::Snapshot, :all, project_id, params
      end

      # Creates snapshot for the given project
      #
      # @see https://developers.lokalise.com/reference/create-a-snapshot
      # @return [RubyLokaliseApi::Resources::Snapshot]
      # @param project_id [String]
      # @param params [Hash]
      def create_snapshot(project_id, params = {})
        c_r RubyLokaliseApi::Resources::Snapshot, :create, project_id, params
      end

      # Restore project from the given snapshot by producing project's copy
      #
      # @see https://developers.lokalise.com/reference/restore-a-snapshot
      # @return [RubyLokaliseApi::Resources::Project]
      # @param project_id [String]
      # @param snapshot_id [String, Integer]
      def restore_snapshot(project_id, snapshot_id)
        c_r RubyLokaliseApi::Resources::Snapshot, :restore, [project_id, snapshot_id]
      end

      # Deletes snapshot
      #
      # @see https://developers.lokalise.com/reference/delete-a-snapshot
      # @return [Hash]
      # @param project_id [String]
      # @param snapshot_id [String, Integer]
      def destroy_snapshot(project_id, snapshot_id)
        c_r RubyLokaliseApi::Resources::Snapshot, :destroy, [project_id, snapshot_id]
      end
    end
  end
end
