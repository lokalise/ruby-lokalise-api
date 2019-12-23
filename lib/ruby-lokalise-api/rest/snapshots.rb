# frozen_string_literal: true

module Lokalise
  class Client
    # Returns all snapshots for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-snapshots-get
    # @return [Lokalise::Collection::Snapshot<Lokalise::Resources::Snapshot>]
    # @param project_id [String]
    # @param params [Hash]
    def snapshots(project_id, params = {})
      c_r Lokalise::Collections::Snapshot, :all, project_id, params
    end

    # Creates snapshot for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-create-a-snapshot-post
    # @return [Lokalise::Resources::Snapshot]
    # @param project_id [String]
    # @param params [Hash]
    def create_snapshot(project_id, params = {})
      c_r Lokalise::Resources::Snapshot, :create, project_id, params
    end

    # Restore project from the given snapshot by producing project's copy
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-restore-a-snapshot-post
    # @return [Lokalise::Resources::Project]
    # @param project_id [String]
    # @param snapshot_id [String, Integer]
    def restore_snapshot(project_id, snapshot_id)
      c_r Lokalise::Resources::Snapshot, :restore, [project_id, snapshot_id]
    end

    # Deletes snapshot
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-snapshot-delete
    # @return [Hash]
    # @param project_id [String]
    # @param snapshot_id [String, Integer]
    def destroy_snapshot(project_id, snapshot_id)
      c_r Lokalise::Resources::Snapshot, :destroy, [project_id, snapshot_id]
    end
  end
end
