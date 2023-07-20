# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Keys < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::KeysEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Key
    end
  end
end
