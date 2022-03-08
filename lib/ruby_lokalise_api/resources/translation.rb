# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Translation < Base
      ID_KEY = 'translation_id'
      supports :update, [:reload_data, '', :find]

      class << self
        def endpoint(project_id, translation_id = nil)
          path_from projects: project_id,
                    translations: translation_id
        end
      end
    end
  end
end