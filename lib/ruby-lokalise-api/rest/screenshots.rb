module Lokalise
  class Client
    # Returns all screenshots for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-screenshots-get
    # @return [Lokalise::Collection::Screenshot<Lokalise::Resources::Screenshot>]
    # @param project_id [String]
    # @param params [Hash]
    def screenshots(project_id, params = {})
      c_r Lokalise::Collections::Screenshot, :all, project_id, params
    end

    # Returns a single screenshot for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-screenshot-get
    # @return [Lokalise::Resources::Screenshot]
    # @param project_id [String]
    # @param screenshot_id [String, Integer]
    def screenshot(project_id, screenshot_id)
      c_r Lokalise::Resources::Screenshot, :find, [project_id, screenshot_id]
    end

    # Creates one or more screenshots for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-create-screenshots-post
    # @return [Lokalise::Collection::Screenshot<Lokalise::Resources::Screenshot>]
    # @param project_id [String]
    # @param params [Hash]
    def create_screenshots(project_id, params = {})
      c_r Lokalise::Resources::Screenshot, :create, project_id, params, :screenshots
    end

    # Updates screenshot
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-screenshot-put
    # @return [Lokalise::Resources::Screenshot]
    # @param project_id [String]
    # @param screenshot_id [String, Integer]
    # @param params [Hash]
    def update_screenshot(project_id, screenshot_id, params = {})
      c_r Lokalise::Resources::Screenshot, :update, [project_id, screenshot_id], params
    end

    # Deletes screenshot
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-screenshot-delete
    # @return [Hash]
    # @param project_id [String]
    # @param screenshot_id [String, Integer]
    def destroy_screenshot(project_id, screenshot_id)
      c_r Lokalise::Resources::Screenshot, :destroy, [project_id, screenshot_id]
    end
  end
end
