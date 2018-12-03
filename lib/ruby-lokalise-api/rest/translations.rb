module Lokalise
  class Client
    def translations(project_id, params = {})
      Lokalise::Collections::Translation.all @token, params, project_id
    end

    def translation(project_id, translation_id, params = {})
      Lokalise::Resources::Translation.find @token, project_id, translation_id, params
    end

    def update_translation(project_id, translation_id, params)
      Lokalise::Resources::Translation.update @token, project_id, translation_id, params
    end
  end
end
