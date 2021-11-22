# frozen_string_literal: true

module Lokalise
  module Resources
    class ProjectLanguage < Base
      DATA_KEY = 'Language'
      ID_KEY = 'lang_id'
      supports :update, :destroy, [:reload_data, '', :find]

      class << self
        def endpoint(project_id, language_id = nil)
          path_from projects: project_id,
                    languages: language_id
        end
      end
    end
  end
end
