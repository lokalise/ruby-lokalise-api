# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Branches
      # Returns all branches for the given project
      #
      # @see https://lokalise.com/api2docs/curl/#transition-list-all-branches-get
      # @return [RubyLokaliseApi::Collection::Branch<RubyLokaliseApi::Resources::Branch>]
      # @param project_id [String]
      # @param params [Hash]
      def branches(project_id, params = {})
        c_r RubyLokaliseApi::Collections::Branch, :all, project_id, params
      end

      # Creates a new branch inside the given project
      #
      # @see https://lokalise.com/api2docs/curl/#transition-create-a-branch-post
      # @return [RubyLokaliseApi::Resources::Branch]
      # @param project_id [String]
      # @param params [Hash]
      def create_branch(project_id, params)
        c_r RubyLokaliseApi::Resources::Branch, :create, project_id, params
      end

      # Returns a single branch for the given project
      #
      # @see https://lokalise.com/api2docs/curl/#transition-retrieve-a-branch-get
      # @return [RubyLokaliseApi::Resources::Branch]
      # @param project_id [String]
      # @param branch_id [String, Integer]
      def branch(project_id, branch_id)
        c_r RubyLokaliseApi::Resources::Branch, :find, [project_id, branch_id]
      end

      # Updates the given branch inside the given project
      #
      # @see https://lokalise.com/api2docs/curl/#transition-update-a-branch-put
      # @return [RubyLokaliseApi::Resources::Branch]
      # @param project_id [String]
      # @param branch_id [String, Integer]
      # @param params [Hash]
      def update_branch(project_id, branch_id, params)
        c_r RubyLokaliseApi::Resources::Branch, :update, [project_id, branch_id], params
      end

      # Deletes branch inside the given project
      #
      # @see https://lokalise.com/api2docs/curl/#transition-delete-a-branch-delete
      # @return [Hash]
      # @param project_id [String]
      # @param branch_id [String, Integer]
      def destroy_branch(project_id, branch_id)
        c_r RubyLokaliseApi::Resources::Branch, :destroy, [project_id, branch_id]
      end

      # Merges a branch in the project
      #
      # @see https://lokalise.com/api2docs/curl/#transition-merge-a-branch-post
      # @return [Hash]
      # @param project_id [String]
      # @param branch_id [String, Integer]
      # @param params [Hash]
      def merge_branch(project_id, branch_id, params = {})
        c_r RubyLokaliseApi::Resources::Branch, :merge, [project_id, branch_id, :merge], params
      end
    end
  end
end
