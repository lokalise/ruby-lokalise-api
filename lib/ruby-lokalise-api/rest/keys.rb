module Lokalise
  class Client
    def keys(project_id, params = {})
      Lokalise::Collections::Key.all @token, params.merge(id: project_id)
    end
  end
end
