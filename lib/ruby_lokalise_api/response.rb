# frozen_string_literal: true

module RubyLokaliseApi
  # This class is utilized to prepare Lokalise API response
  class Response
    # Lokalise returns pagination info in special headers
    PAGINATION_HEADERS = %w[x-pagination-total-count x-pagination-page-count x-pagination-limit
                            x-pagination-page x-pagination-next-cursor].freeze

    attr_reader :content, :endpoint, :headers

    def initialize(body, endpoint, raw_headers = {})
      @content = body
      @endpoint = endpoint
      @headers = extract_headers_from raw_headers
    end

    # Adds attribute to the raw content returned by the API.
    # Sometimes this is required to store important data like team_id or project_id
    # that is not returned in the response but required to properly build resources URIs
    def patch_content_with(attribute, value)
      @content[attribute] = value
    end

    # Sets endpoint to a new value.
    # This is required in rare cases when the response contains a resource of different kind.
    # For example, when restoring a snapshot, it returns a new project which means that
    # initially we were working with a snapshots endpoint but the response should contain
    # the projects endpoint to properly preserve method chaining
    def patch_endpoint_with(new_endpoint)
      @endpoint = new_endpoint
    end

    # Returns an array of pagination headers
    def pagination_headers
      self.class.const_get(:PAGINATION_HEADERS)
    end

    private

    # Keep only pagination headers
    def extract_headers_from(raw_headers)
      raw_headers.
        to_h.
        keep_if { |header, _value| pagination_headers.include?(header) }.
        transform_keys(&:to_sym)
    end
  end
end
