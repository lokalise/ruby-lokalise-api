module Lokalise
  class Client
    # Returns all contributors for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-contributors-get
    # @return [Lokalise::Collection::Contributor<Lokalise::Resources::Contributor>]
    # @param project_id [String]
    # @param params [Hash]
    def contributors(project_id, params = {})
      Lokalise::Collections::Contributor.all self, params, project_id
    end

    # Returns a single contributor for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-contributor-get
    # @return [Lokalise::Resources::Contributor]
    # @param project_id [String]
    # @param contributor_id [String, Integer]
    def contributor(project_id, contributor_id)
      Lokalise::Resources::Contributor.find self, project_id, contributor_id
    end

    # Creates one or more contributors inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-create-contributors-post
    # @return [Lokalise::Collection::Contributor<Lokalise::Resources::Contributor>]
    # @param project_id [String]
    # @param params [Hash, Array<Hash>]
    def create_contributors(project_id, params)
      Lokalise::Resources::Contributor.create self, project_id, params, :contributors
    end

    # Updates the given contributor inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-contributor-put
    # @return [Lokalise::Resources::Contributor]
    # @param project_id [String]
    # @param contributor_id [String, Integer]
    # @param params [Hash]
    def update_contributor(project_id, contributor_id, params)
      Lokalise::Resources::Contributor.update self, project_id, contributor_id, params
    end

    # Deletes contributor inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-contributor-delete
    # @return [Hash]
    # @param project_id [String]
    # @param contributor_id [String, Integer]
    def delete_contributor(project_id, contributor_id)
      Lokalise::Resources::Contributor.destroy self, project_id, contributor_id
    end
  end
end
