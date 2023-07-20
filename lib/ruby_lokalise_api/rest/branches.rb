# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Branches
      # Returns project branches
      #
      # @see https://developers.lokalise.com/reference/list-all-branches
      # @return [RubyLokaliseApi::Collections::Branches]
      # @param project_id [String]
      # @param req_params [Hash]
      def branches(project_id, req_params = {})
        name = 'Branches'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single branch
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-branch
      # @return [RubyLokaliseApi::Resources::Branch]
      # @param project_id [String]
      # @param branch_id [String, Integer]
      def branch(project_id, branch_id)
        params = { query: [project_id, branch_id] }

        data = endpoint(name: 'Branches', params: params).do_get

        resource 'Branch', data
      end

      # Creates a branch
      #
      # @see https://developers.lokalise.com/reference/create-a-branch
      # @return [RubyLokaliseApi::Resources::Branch]
      # @param project_id [String]
      # @param req_params [Hash]
      def create_branch(project_id, req_params)
        params = { query: project_id, req: req_params }

        data = endpoint(name: 'Branches', params: params).do_post

        resource 'Branch', data
      end

      # Updates a branch
      #
      # @see https://developers.lokalise.com/reference/update-a-branch
      # @return [RubyLokaliseApi::Resources::Branch]
      # @param project_id [String]
      # @param branch_id [String, Integer]
      # @param req_params [Hash]
      def update_branch(project_id, branch_id, req_params = {})
        params = { query: [project_id, branch_id], req: req_params }

        data = endpoint(name: 'Branches', params: params).do_put

        resource 'Branch', data
      end

      # Deletes a branch
      #
      # @see https://developers.lokalise.com/reference/delete-a-branch
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param branch_id [String, Integer]
      def destroy_branch(project_id, branch_id)
        params = { query: [project_id, branch_id] }

        data = endpoint(name: 'Branches', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end

      # Merges two branches
      #
      # @see https://developers.lokalise.com/reference/merge-a-branch
      # @return [RubyLokaliseApi::Generics::MergedBranches]
      # @param project_id [String]
      # @param branch_id [String, Integer]
      # @param req_params [Hash]
      def merge_branch(project_id, branch_id, req_params)
        params = { query: [project_id, branch_id, :merge], req: req_params }

        data = endpoint(name: 'Branches', params: params).do_post

        RubyLokaliseApi::Generics::MergedBranches.new data.content
      end
    end
  end
end
