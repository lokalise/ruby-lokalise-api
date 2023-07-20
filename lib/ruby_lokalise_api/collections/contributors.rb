# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Contributors < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::ContributorsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Contributor
    end
  end
end
