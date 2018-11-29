module Lokalise
  class Client
    def comment(project_id, key_id, comment_id)
      Lokalise::Resources::KeyComment.find @token, project_id, key_id, comment_id
    end

    def project_comments(project_id, params = {})
      Lokalise::Collections::ProjectComment.all @token, params.merge(id: project_id)
    end

    def comments(project_id, key_id, params = {})
      Lokalise::Collections::KeyComment.all @token, params.merge(
        id: project_id,
        secondary_id: key_id
      )
    end

    def create_comment(project_id, key_id, params)
      Lokalise::Resources::KeyComment.create @token, project_id, key_id, params
    end

    def delete_comment(project_id, key_id, comment_id)
      Lokalise::Resources::KeyComment.destroy @token, project_id, key_id, comment_id
    end
  end
end
