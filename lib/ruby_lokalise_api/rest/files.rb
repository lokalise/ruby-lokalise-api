# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Files
      # Returns all translation files for the given project
      #
      # @see https://developers.lokalise.com/reference/list-all-files
      # @return [RubyLokaliseApi::Collection::File<RubyLokaliseApi::Resources::File>]
      # @param project_id [String]
      # @param params [Hash]
      def files(project_id, params = {})
        c_r RubyLokaliseApi::Collections::File, :all, project_id, params
      end

      # Exports translation files as .zip bundle, uploads them to Amazon S3 and returns a URL to the generated bundle. The URL is valid for a year
      #
      # @see https://developers.lokalise.com/reference/download-files
      # @return [Hash]
      # @param project_id [String]
      # @param params [Hash]
      def download_files(project_id, params)
        c_r RubyLokaliseApi::Resources::File, :download, [project_id, 'download'], params
      end

      # Imports translation file to the given project. File data must base64-encoded.
      # To encode your data in Base64, use `Base64.strict_encode64()` method.
      #
      # @see https://developers.lokalise.com/reference/upload-a-file
      # @return [Hash]
      # @param project_id [String]
      # @param params [Hash]
      def upload_file(project_id, params)
        c_r RubyLokaliseApi::Resources::File, :upload, [project_id, 'upload'], params
      end

      # Deletes a file and it's associated keys from the project.
      # File __unassigned__ cannot be deleted.
      #
      # @see https://developers.lokalise.com/reference/delete-a-file
      # @return [Hash]
      # @param project_id [String]
      # @param params [Hash]
      def destroy_file(project_id, file_id)
        c_r RubyLokaliseApi::Resources::File, :destroy, [project_id, file_id]
      end
    end
  end
end
