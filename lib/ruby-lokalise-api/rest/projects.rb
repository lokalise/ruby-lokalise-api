module Lokalise
  class Client
    # Returns all projects available to the user authorized with the API token
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-projects-get
    # @return [Lokalise::Collection::Project<Lokalise::Resources::Project>]
    # @param params [Hash]
    def projects(params = {})
      Lokalise::Collections::Project.all self, params
    end

    # Returns a single project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-project-get
    # @return [Lokalise::Resources::Project]
    # @param project_id [String, Integer]
    def project(project_id)
      Lokalise::Resources::Project.find self, nil, project_id
    end

    # Creates project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-create-a-project-post
    # @return [Lokalise::Resources::Project]
    # @param params [Hash]
    def create_project(params)
      Lokalise::Resources::Project.create self, nil, params
    end

    # Updates project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-project-put
    # @return [Lokalise::Resources::Project]
    # @param project_id [String, Integer]
    # @param params [Hash]
    def update_project(project_id, params)
      Lokalise::Resources::Project.update self, nil, project_id, params
    end

    # Deletes all keys and translations from the project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-empty-a-project-put
    # @return [Hash]
    # @param project_id [String, Integer]
    def empty_project(project_id)
      Lokalise::Resources::Project.clear self, project_id
    end

    # Deletes the project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-project-delete
    # @return [Hash]
    # @param project_id [String, Integer]
    def delete_project(project_id)
      Lokalise::Resources::Project.destroy self, nil, project_id
    end
  end
end
