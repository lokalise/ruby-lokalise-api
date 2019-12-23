# frozen_string_literal: true

module Lokalise
  class Client
    # Returns all contributors for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-contributors-get
    # @return [Lokalise::Collection::Contributor<Lokalise::Resources::Contributor>]
    # @param project_id [String]
    # @param params [Hash]
    def contributors(project_id, params = {})
      c_r Lokalise::Collections::Contributor, :all, project_id, params
    end

    # Returns a single contributor for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-contributor-get
    # @return [Lokalise::Resources::Contributor]
    # @param project_id [String]
    # @param contributor_id [String, Integer]
    def contributor(project_id, contributor_id)
      c_r Lokalise::Resources::Contributor, :find, [project_id, contributor_id]
    end

    # Creates one or more contributors inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-create-contributors-post
    # @return [Lokalise::Collection::Contributor<Lokalise::Resources::Contributor>]
    # @param project_id [String]
    # @param params [Hash, Array<Hash>]
    def create_contributors(project_id, params)
      c_r Lokalise::Resources::Contributor, :create, project_id, params, :contributors
    end

    # Updates the given contributor inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-contributor-put
    # @return [Lokalise::Resources::Contributor]
    # @param project_id [String]
    # @param contributor_id [String, Integer]
    # @param params [Hash]
    def update_contributor(project_id, contributor_id, params)
      c_r Lokalise::Resources::Contributor, :update, [project_id, contributor_id], params
    end

    # Deletes contributor inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-contributor-delete
    # @return [Hash]
    # @param project_id [String]
    # @param contributor_id [String, Integer]
    def destroy_contributor(project_id, contributor_id)
      c_r Lokalise::Resources::Contributor, :destroy, [project_id, contributor_id]
    end
  end
end
