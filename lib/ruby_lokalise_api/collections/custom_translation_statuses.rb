# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class CustomTranslationStatuses < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::CustomTranslationStatusesEndpoint
      RESOURCE = RubyLokaliseApi::Resources::CustomTranslationStatus
    end
  end
end
