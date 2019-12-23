# frozen_string_literal: true

module Lokalise
  module Resources
    class CustomTranslationStatus < Base
      ID_KEY = 'status'
      supports :update, :destroy

      class << self
        def colors(client, path, *_args)
          get(path, client)['content']['colors']
        end

        def endpoint(project_id, status_id = nil)
          path_from projects: project_id,
                    custom_translation_statuses: status_id
        end
      end
    end
  end
end
