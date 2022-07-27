# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Contributors
      # Returns all contributors for the given project
      #
      # @see https://developers.lokalise.com/reference/list-all-contributors
      # @return [RubyLokaliseApi::Collection::Contributor<RubyLokaliseApi::Resources::Contributor>]
      # @param project_id [String]
      # @param params [Hash]
      def contributors(project_id, params = {})
        c_r RubyLokaliseApi::Collections::Contributor, :all, project_id, params
      end

      # Returns a single contributor for the given project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-contributor
      # @return [RubyLokaliseApi::Resources::Contributor]
      # @param project_id [String]
      # @param contributor_id [String, Integer]
      def contributor(project_id, contributor_id)
        c_r RubyLokaliseApi::Resources::Contributor, :find, [project_id, contributor_id]
      end

      # Creates one or more contributors inside the given project
      #
      # @see https://developers.lokalise.com/reference/create-contributors
      # @return [RubyLokaliseApi::Collection::Contributor<RubyLokaliseApi::Resources::Contributor>]
      # @param project_id [String]
      # @param params [Hash, Array<Hash>]
      def create_contributors(project_id, params)
        c_r RubyLokaliseApi::Resources::Contributor, :create, project_id, params, :contributors
      end

      # Updates the given contributor inside the given project
      #
      # @see https://developers.lokalise.com/reference/update-a-contributor
      # @return [RubyLokaliseApi::Resources::Contributor]
      # @param project_id [String]
      # @param contributor_id [String, Integer]
      # @param params [Hash]
      def update_contributor(project_id, contributor_id, params)
        c_r RubyLokaliseApi::Resources::Contributor, :update, [project_id, contributor_id], params
      end

      # Deletes contributor inside the given project
      #
      # @see https://developers.lokalise.com/reference/delete-a-contributor
      # @return [Hash]
      # @param project_id [String]
      # @param contributor_id [String, Integer]
      def destroy_contributor(project_id, contributor_id)
        c_r RubyLokaliseApi::Resources::Contributor, :destroy, [project_id, contributor_id]
      end
    end
  end
end
