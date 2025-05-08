# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Contributors
      using RubyLokaliseApi::Utils::Classes

      # Returns a single contributor
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-contributor
      # @return [RubyLokaliseApi::Resources::Contributor]
      # @param project_id [String]
      # @param contributor_id [String, Integer]
      def contributor(project_id, contributor_id)
        params = { query: [project_id, contributor_id] }

        data = endpoint(name: 'Contributors', params: params).do_get

        resource 'Contributor', data
      end

      # Returns current contributor (me)
      #
      # @see https://developers.lokalise.com/reference/retrieve-me-as-a-contributor
      # @return [RubyLokaliseApi::Resources::Contributor]
      # @param project_id [String]
      def current_contributor(project_id)
        params = { query: [project_id, :me] }

        data = endpoint(name: 'Contributors', params: params).do_get

        resource 'Contributor', data
      end

      # Returns project contributors
      #
      # @see https://developers.lokalise.com/reference/list-all-contributors
      # @return [RubyLokaliseApi::Collections::Contributors]
      # @param project_id [String]
      # @param req_params [Hash]
      def contributors(project_id, req_params = {})
        name = 'Contributors'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Creates one or multiple contributors for a project
      #
      # @see https://developers.lokalise.com/reference/create-contributors
      # @return [RubyLokaliseApi::Collections::Contributors]
      # @param project_id [String]
      # @param req_params [Hash, Array]
      def create_contributors(project_id, req_params)
        name = 'Contributors'
        params = { query: project_id, req: req_params.to_array_obj(:contributors) }

        data = endpoint(name: name, params: params).do_post

        collection name, data
      end

      # Updates a contributor for a project
      #
      # @see https://developers.lokalise.com/reference/update-a-contributor
      # @return [RubyLokaliseApi::Resources::Contributor]
      # @param project_id [String]
      # @param contributor_id [String, Integer]
      # @param req_params [Hash]
      def update_contributor(project_id, contributor_id, req_params)
        params = { query: [project_id, contributor_id], req: req_params }

        data = endpoint(name: 'Contributors', params: params).do_put

        resource 'Contributor', data
      end

      # Deletes a single contributor from the project
      #
      # @see https://developers.lokalise.com/reference/delete-a-contributor
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param contributor_id [String, Integer]
      def destroy_contributor(project_id, contributor_id)
        params = { query: [project_id, contributor_id] }

        data = endpoint(name: 'Contributors', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end
