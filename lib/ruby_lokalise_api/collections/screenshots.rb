# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Screenshots < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::ScreenshotsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Screenshot
    end
  end
end
