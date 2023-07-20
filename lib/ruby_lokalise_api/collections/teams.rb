# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Teams < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::TeamsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Team
    end
  end
end
