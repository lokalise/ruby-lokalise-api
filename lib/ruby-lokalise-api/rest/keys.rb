module Lokalise
  class Client
    def keys(project_id, params = {})
      Lokalise::Collections::Key.all self, params, project_id
    end

    def key(project_id, key_id, params = {})
      Lokalise::Resources::Key.find self, project_id, key_id, params
    end

    def create_keys(project_id, params = {})
      Lokalise::Resources::Key.create self, project_id, params, :keys
    end

    def update_key(project_id, key_id, params = {})
      Lokalise::Resources::Key.update self, project_id, key_id, params
    end

    def update_keys(project_id, params)
      Lokalise::Resources::Key.update self, project_id, nil, params, :keys
    end

    def delete_key(project_id, key_id)
      Lokalise::Resources::Key.destroy self, project_id, key_id
    end

    def delete_keys(project_id, key_ids)
      Lokalise::Resources::Key.destroy self, project_id, keys: key_ids
    end
  end
end
