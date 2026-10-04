# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class TranslationMemoriesEndpoint < MainEndpoint
      private

      def base_query(project_id, *_args)
        {
          projects: project_id,
          'translation-memories': nil
        }
      end
    end
  end
end
