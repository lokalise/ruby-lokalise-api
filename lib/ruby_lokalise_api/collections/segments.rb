# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Segments < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::SegmentsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Segment
    end
  end
end
