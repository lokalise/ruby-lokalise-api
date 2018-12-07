module Lokalise
  class Client
    def files(project_id, params = {})
      Lokalise::Collections::File.all self, params, project_id
    end

    def download_files(project_id, params)
      Lokalise::Resources::File.download self, project_id, params
    end

    def upload_file(project_id, params)
      Lokalise::Resources::File.upload self, project_id, params
    end
  end
end
