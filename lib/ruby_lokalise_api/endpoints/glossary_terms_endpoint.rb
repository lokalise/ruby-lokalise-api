# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class GlossaryTermsEndpoint < MainEndpoint
      private

      def base_query(project_id, term_id = nil)
        {
          projects: project_id,
          'glossary-terms': term_id
        }
      end
    end
  end
end
