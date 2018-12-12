module Lokalise
  class Client
    # Returns all translation files for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-files-get
    # @return [Lokalise::Collection::File<Lokalise::Resources::File>]
    # @param project_id [String]
    # @param params [Hash]
    def files(project_id, params = {})
      c_r Lokalise::Collections::File, :all, project_id, params
    end

    # Exports translation files as .zip bundle, uploads them to Amazon S3 and returns a URL to the generated bundle. The URL is valid for a year
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-download-files-post
    # @return [Hash]
    # @param project_id [String]
    # @param params [Hash]
    def download_files(project_id, params)
      c_r Lokalise::Resources::File, :download, [project_id, 'download'], params
    end

    # Imports translation file to the given project. File data must base64-encoded
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-upload-a-file-post
    # @return [Hash]
    # @param project_id [String]
    # @param params [Hash]
    def upload_file(project_id, params)
      c_r Lokalise::Resources::File, :upload, [project_id, 'upload'], params
    end
  end
end
