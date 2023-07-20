# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class ProjectComments < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::ProjectCommentsEndpoint
      RESOURCES_ENDPOINT = RubyLokaliseApi::Endpoints::KeyCommentsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Comment
      DATA_KEY = 'comments'
    end
  end
end
