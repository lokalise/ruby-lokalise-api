module Lokalise
  class Client
    def keys(project_id, params = {})
      Lokalise::Collections::Key.all @token, params, project_id
    end

    def key(project_id, key_id, params = {})
      Lokalise::Resources::Key.find @token, project_id, key_id, params
    end

    def create_keys(project_id, params = {})
      Lokalise::Resources::Key.create @token, project_id, params, :keys
    end

    def update_key(project_id, key_id, params = {})
      Lokalise::Resources::Key.update @token, project_id, key_id, params
    end

    def update_keys(project_id, params)
      Lokalise::Resources::Key.update @token, project_id, nil, params, :keys
    end

    def delete_key(project_id, key_id)
      Lokalise::Resources::Key.destroy @token, project_id, key_id
    end

    def delete_keys(project_id, key_ids)
      Lokalise::Resources::Key.destroy @token, project_id, keys: key_ids
    end
  end
end
