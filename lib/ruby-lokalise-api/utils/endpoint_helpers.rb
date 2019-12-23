# frozen_string_literal: true

module Lokalise
  module Utils
    module EndpointHelpers
      def path_from(raw_mapping)
        template = Addressable::Template.new '{/segments*}'
        template.expand(
          segments: raw_mapping.to_a.flatten
        ).to_s
      end
    end
  end
end
