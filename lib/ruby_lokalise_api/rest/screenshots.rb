# frozen_string_literal: true

module RubyLokaliseApi
  class Client
    # Returns all screenshots for the given project
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-list-all-screenshots-get
    # @return [RubyLokaliseApi::Collection::Screenshot<RubyLokaliseApi::Resources::Screenshot>]
    # @param project_id [String]
    # @param params [Hash]
    def screenshots(project_id, params = {})
      c_r RubyLokaliseApi::Collections::Screenshot, :all, project_id, params
    end

    # Returns a single screenshot for the given project
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-retrieve-a-screenshot-get
    # @return [RubyLokaliseApi::Resources::Screenshot]
    # @param project_id [String]
    # @param screenshot_id [String, Integer]
    def screenshot(project_id, screenshot_id)
      c_r RubyLokaliseApi::Resources::Screenshot, :find, [project_id, screenshot_id]
    end

    # Creates one or more screenshots for the given project
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-create-screenshots-post
    # @return [RubyLokaliseApi::Collection::Screenshot<RubyLokaliseApi::Resources::Screenshot>]
    # @param project_id [String]
    # @param params [Hash]
    def create_screenshots(project_id, params = {})
      c_r RubyLokaliseApi::Resources::Screenshot, :create, project_id, params, :screenshots
    end

    # Updates screenshot
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-update-a-screenshot-put
    # @return [RubyLokaliseApi::Resources::Screenshot]
    # @param project_id [String]
    # @param screenshot_id [String, Integer]
    # @param params [Hash]
    def update_screenshot(project_id, screenshot_id, params = {})
      c_r RubyLokaliseApi::Resources::Screenshot, :update, [project_id, screenshot_id], params
    end

    # Deletes screenshot
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-delete-a-screenshot-delete
    # @return [Hash]
    # @param project_id [String]
    # @param screenshot_id [String, Integer]
    def destroy_screenshot(project_id, screenshot_id)
      c_r RubyLokaliseApi::Resources::Screenshot, :destroy, [project_id, screenshot_id]
    end
  end
end
