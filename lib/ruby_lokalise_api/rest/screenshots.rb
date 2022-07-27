# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Screenshots
      # Returns all screenshots for the given project
      #
      # @see https://developers.lokalise.com/reference/list-all-screenshots
      # @return [RubyLokaliseApi::Collection::Screenshot<RubyLokaliseApi::Resources::Screenshot>]
      # @param project_id [String]
      # @param params [Hash]
      def screenshots(project_id, params = {})
        c_r RubyLokaliseApi::Collections::Screenshot, :all, project_id, params
      end

      # Returns a single screenshot for the given project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-screenshot
      # @return [RubyLokaliseApi::Resources::Screenshot]
      # @param project_id [String]
      # @param screenshot_id [String, Integer]
      def screenshot(project_id, screenshot_id)
        c_r RubyLokaliseApi::Resources::Screenshot, :find, [project_id, screenshot_id]
      end

      # Creates one or more screenshots for the given project
      #
      # @see https://developers.lokalise.com/reference/create-screenshots
      # @return [RubyLokaliseApi::Collection::Screenshot<RubyLokaliseApi::Resources::Screenshot>]
      # @param project_id [String]
      # @param params [Hash]
      def create_screenshots(project_id, params = {})
        c_r RubyLokaliseApi::Resources::Screenshot, :create, project_id, params, :screenshots
      end

      # Updates screenshot
      #
      # @see https://developers.lokalise.com/reference/update-a-screenshot
      # @return [RubyLokaliseApi::Resources::Screenshot]
      # @param project_id [String]
      # @param screenshot_id [String, Integer]
      # @param params [Hash]
      def update_screenshot(project_id, screenshot_id, params = {})
        c_r RubyLokaliseApi::Resources::Screenshot, :update, [project_id, screenshot_id], params
      end

      # Deletes screenshot
      #
      # @see https://developers.lokalise.com/reference/delete-a-screenshot
      # @return [Hash]
      # @param project_id [String]
      # @param screenshot_id [String, Integer]
      def destroy_screenshot(project_id, screenshot_id)
        c_r RubyLokaliseApi::Resources::Screenshot, :destroy, [project_id, screenshot_id]
      end
    end
  end
end
