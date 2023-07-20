# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Projects
      # Returns a single project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-project
      # @return [RubyLokaliseApi::Resources::Project]
      # @param project_id [String]
      def project(project_id)
        params = { query: project_id }

        data = endpoint(name: 'Projects', params: params).do_get

        resource 'Project', data
      end

      # Returns a collection of projects
      #
      # @see https://developers.lokalise.com/reference/list-all-projects
      # @return [RubyLokaliseApi::Collections::Projects]
      # @param req_params [Hash]
      def projects(req_params = {})
        name = 'Projects'
        params = { req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Creates a project
      #
      # @see https://developers.lokalise.com/reference/create-a-project
      # @return [RubyLokaliseApi::Resources::Project]
      # @param req_params [Hash]
      def create_project(req_params)
        params = { req: req_params }

        data = endpoint(name: 'Projects', params: params).do_post

        resource 'Project', data
      end

      # Updates a project
      #
      # @see https://developers.lokalise.com/reference/update-a-project
      # @return [RubyLokaliseApi::Resources::Project]
      # @param project_id [String]
      # @param req_params [Hash]
      def update_project(project_id, req_params)
        params = { query: project_id, req: req_params }

        data = endpoint(name: 'Projects', params: params).do_put

        resource 'Project', data
      end

      # Deletes a project
      #
      # @see https://developers.lokalise.com/reference/delete-a-project
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      def destroy_project(project_id)
        params = { query: project_id }

        data = endpoint(name: 'Projects', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end

      # Empties a project by deleting all keys and translations
      #
      # @see https://developers.lokalise.com/reference/empty-a-project
      # @return [RubyLokaliseApi::Generics::EmptiedResource]
      # @param project_id [String]
      def empty_project(project_id)
        data = endpoint(name: 'Projects', params: { query: [project_id, :empty] }).do_put

        RubyLokaliseApi::Generics::EmptiedResource.new data.content
      end
    end
  end
end
