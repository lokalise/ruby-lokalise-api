# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class GlossaryTerms < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::GlossaryTermsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::GlossaryTerm
      DATA_KEY = 'data'
    end
  end
end
