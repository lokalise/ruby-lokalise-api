# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Files
      # Returns project files
      #
      # @see https://developers.lokalise.com/reference/list-all-files
      # @return [RubyLokaliseApi::Collections::Files]
      # @param project_id [String]
      # @param req_params [Hash]
      def files(project_id, req_params = {})
        name = 'Files'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Uploads translation file to the project in the background
      #
      # @see https://developers.lokalise.com/reference/upload-a-file
      # @return [RubyLokaliseApi::Resources::QueuedProcess]
      # @param project_id [String]
      # @param req_params [Hash]
      def upload_file(project_id, req_params)
        params = { query: [project_id, :upload], req: req_params }

        response = endpoint(name: 'Files', params: params).do_post

        process_id = response.content.dig('process', 'process_id')

        response.patch_endpoint_with endpoint(name: 'QueuedProcesses', params: { query: [project_id, process_id] })

        resource 'QueuedProcess', response
      end

      # Downloads translation files from the project
      #
      # @see https://developers.lokalise.com/reference/download-files
      # @return [RubyLokaliseApi::Generics::DownloadBundle]
      # @param project_id [String]
      # @param req_params [Hash]
      def download_files(project_id, req_params)
        params = { query: [project_id, :download], req: req_params }

        data = endpoint(name: 'Files', params: params).do_post

        RubyLokaliseApi::Generics::DownloadBundle.new data.content
      end

      # Downloads translation files from the project asynchronously
      #
      # @see https://developers.lokalise.com/reference/download-files-async
      # @return [RubyLokaliseApi::Resources::QueuedProcess]
      # @param project_id [String]
      # @param req_params [Hash]
      def download_files_async(project_id, req_params)
        params = { query: [project_id, :'async-download'], req: req_params }

        response = endpoint(name: 'Files', params: params).do_post

        process_id = response.content['process_id']

        response.patch_endpoint_with endpoint(name: 'QueuedProcesses', params: { query: [project_id, process_id] })

        resource 'QueuedProcess', response
      end

      # Deletes a single file from the project.
      # Only the "Documents" projects are supported
      #
      # @see https://developers.lokalise.com/reference/delete-a-file
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param file_id [String, Integer]
      def destroy_file(project_id, file_id)
        params = { query: [project_id, file_id] }

        data = endpoint(name: 'Files', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end
