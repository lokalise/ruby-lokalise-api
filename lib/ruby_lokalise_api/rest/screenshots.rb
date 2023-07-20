# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Screenshots
      using RubyLokaliseApi::Utils::Classes

      # Returns project screenshots
      #
      # @see https://developers.lokalise.com/reference/list-all-screenshots
      # @return [RubyLokaliseApi::Collections::Screenshots]
      # @param project_id [String]
      # @param req_params [Hash]
      def screenshots(project_id, req_params = {})
        name = 'Screenshots'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single screenshot
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-screenshot
      # @return [RubyLokaliseApi::Resources::Screenshot]
      # @param project_id [String]
      # @param screenshot_id [String, Integer]
      # @param req_params[Hash]
      def screenshot(project_id, screenshot_id, req_params = {})
        params = { query: [project_id, screenshot_id], req: req_params }

        data = endpoint(name: 'Screenshots', params: params).do_get

        resource 'Screenshot', data
      end

      # Creates a new order
      #
      # @see https://developers.lokalise.com/reference/create-screenshots
      # @return [RubyLokaliseApi::Collections::Screenshots]
      # @param project_id [String]
      # @param req_params [Hash, Array]
      def create_screenshots(project_id, req_params)
        name = 'Screenshots'
        params = { query: project_id, req: req_params.to_array_obj(:screenshots) }

        data = endpoint(name: name, params: params).do_post

        collection name, data
      end

      # Updates a screenshot
      #
      # @see https://developers.lokalise.com/reference/update-a-screenshot
      # @return [RubyLokaliseApi::Resources::Screenshot]
      # @param project_id [String]
      # @param screenshot_id [String, Integer]
      # @param req_params [Hash]
      def update_screenshot(project_id, screenshot_id, req_params = {})
        params = { query: [project_id, screenshot_id], req: req_params }

        data = endpoint(name: 'Screenshots', params: params).do_put

        resource 'Screenshot', data
      end

      # Deletes a screenshot
      #
      # @see https://developers.lokalise.com/reference/delete-a-screenshot
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param screenshot_id [String, Integer]
      def destroy_screenshot(project_id, screenshot_id)
        params = { query: [project_id, screenshot_id] }

        data = endpoint(name: 'Screenshots', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end
