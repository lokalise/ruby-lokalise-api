module Lokalise
  class Client
    def comment(project_id, key_id, comment_id)
      Lokalise::Resources::KeyComment.find self, [project_id, key_id], comment_id
    end

    def project_comments(project_id, params = {})
      Lokalise::Collections::ProjectComment.all self, params, project_id
    end

    def comments(project_id, key_id, params = {})
      Lokalise::Collections::KeyComment.all self, params, project_id, key_id
    end

    def create_comments(project_id, key_id, params)
      Lokalise::Resources::KeyComment.create self, [project_id, key_id], params, :comments
    end

    def delete_comment(project_id, key_id, comment_id)
      Lokalise::Resources::KeyComment.destroy self, [project_id, key_id], comment_id
    end
  end
end
