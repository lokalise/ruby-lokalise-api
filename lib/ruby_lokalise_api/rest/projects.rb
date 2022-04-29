# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Projects
      # Returns all projects available to the user authorized with the API token
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-list-all-projects-get
      # @return [RubyLokaliseApi::Collection::Project<RubyLokaliseApi::Resources::Project>]
      # @param params [Hash]
      def projects(params = {})
        c_r RubyLokaliseApi::Collections::Project, :all, nil, params
      end

      # Returns a single project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-retrieve-a-project-get
      # @return [RubyLokaliseApi::Resources::Project]
      # @param project_id [String, Integer]
      def project(project_id)
        c_r RubyLokaliseApi::Resources::Project, :find, project_id
      end

      # Creates project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-create-a-project-post
      # @return [RubyLokaliseApi::Resources::Project]
      # @param params [Hash]
      def create_project(params)
        c_r RubyLokaliseApi::Resources::Project, :create, nil, params
      end

      # Updates project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-update-a-project-put
      # @return [RubyLokaliseApi::Resources::Project]
      # @param project_id [String, Integer]
      # @param params [Hash]
      def update_project(project_id, params)
        c_r RubyLokaliseApi::Resources::Project, :update, project_id, params
      end

      # Deletes all keys and translations from the project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-empty-a-project-put
      # @return [Hash]
      # @param project_id [String, Integer]
      def empty_project(project_id)
        c_r RubyLokaliseApi::Resources::Project, :empty, [project_id, 'empty']
      end

      # Deletes the project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-delete-a-project-delete
      # @return [Hash]
      # @param project_id [String, Integer]
      def destroy_project(project_id)
        c_r RubyLokaliseApi::Resources::Project, :destroy, project_id
      end
    end
  end
end
