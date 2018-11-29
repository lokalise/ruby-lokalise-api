module Lokalise
  class Client
    def files(project_id, params = {})
      Lokalise::Collections::File.all @token, params.merge(id: project_id)
    end

    def download_files(project_id, params)
      Lokalise::Resources::File.download @token, project_id, params
    end

    def upload_file(project_id, params)
      Lokalise::Resources::File.upload @token, project_id, params
    end
  end
end
