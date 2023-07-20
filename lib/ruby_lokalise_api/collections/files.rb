# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Files < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::FilesEndpoint
      RESOURCE = RubyLokaliseApi::Resources::File
    end
  end
end
