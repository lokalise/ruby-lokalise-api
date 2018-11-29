module Lokalise
  class Client
    def contributors(project_id, params = {})
      Lokalise::Collections::Contributor.all @token, params.merge(id: project_id)
    end

    def contributor(project_id, contributor_id)
      Lokalise::Resources::Contributor.find @token, project_id, contributor_id
    end

    def create_contributors(project_id, params)
      Lokalise::Resources::Contributor.create @token, project_id, params
    end

    def update_contributor(project_id, contributor_id, params)
      Lokalise::Resources::Contributor.update @token, project_id, contributor_id, params
    end

    def delete_contributor(project_id, contributor_id)
      Lokalise::Resources::Contributor.destroy @token, project_id, contributor_id
    end
  end
end
