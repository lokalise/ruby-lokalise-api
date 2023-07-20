# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class TranslationsEndpoint < MainEndpoint
      private

      def base_query(project_id, translation_id = nil)
        {
          projects: project_id,
          translations: translation_id
        }
      end
    end
  end
end
