# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class CustomTranslationStatus < Base
      DATA_KEY_PLURAL = 'CustomTranslationStatuses'

      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'custom_translation_statuses']
        end
      end
    end
  end
end
