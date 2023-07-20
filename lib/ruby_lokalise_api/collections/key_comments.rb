# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class KeyComments < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::KeyCommentsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Comment
      DATA_KEY = 'comments'
    end
  end
end
