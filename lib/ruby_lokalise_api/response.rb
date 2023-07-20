# frozen_string_literal: true

module RubyLokaliseApi
  class Response
    # Lokalise returns pagination info in special headers
    PAGINATION_HEADERS = %w[x-pagination-total-count x-pagination-page-count x-pagination-limit
                            x-pagination-page].freeze

    attr_reader :content, :endpoint, :headers

    def initialize(body, endpoint, raw_headers = {})
      @content = body
      @endpoint = endpoint
      @headers = extract_headers_from raw_headers
    end

    def patch_content_with(attribute, value)
      @content[attribute] = value
    end

    def patch_endpoint_with(new_endpoint)
      @endpoint = new_endpoint
    end

    def pagination_headers
      self.class.const_get(:PAGINATION_HEADERS)
    end

    private

    # Keep only pagination headers
    def extract_headers_from(raw_headers)
      raw_headers.
        to_h.
        keep_if { |header, _value| pagination_headers.include?(header) }.
        transform_keys(&:to_sym).
        transform_values(&:to_i)
    end
  end
end
