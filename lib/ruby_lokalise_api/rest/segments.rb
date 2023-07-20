# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Segments
      # Returns project segments
      #
      # @see https://developers.lokalise.com/reference/list-all-segments-for-key-language
      # @return [RubyLokaliseApi::Collections::Segments]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param language_iso [String]
      # @param req_params [Hash]
      def segments(project_id, key_id, language_iso, req_params = {})
        name = 'Segments'
        params = { query: [project_id, key_id, language_iso], req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single project segment
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-segment-for-key-language
      # @return [RubyLokaliseApi::Resources::Segment]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param language_iso [String]
      # @param segment_number [String, Integer]
      # @param req_params [Hash]
      def segment(project_id, key_id, language_iso, segment_number, req_params = {})
        params = { query: [project_id, key_id, language_iso, segment_number], req: req_params }

        data = endpoint(name: 'Segments', params: params).do_get

        resource 'Segment', data
      end

      # Updates a segment
      #
      # @see https://developers.lokalise.com/reference/update-a-segment
      # @return [RubyLokaliseApi::Resources::Segment]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param language_iso [String]
      # @param segment_number [String, Integer]
      # @param req_params [Hash]
      def update_segment(project_id, key_id, language_iso, segment_number, req_params = {})
        params = { query: [project_id, key_id, language_iso, segment_number], req: req_params }

        data = endpoint(name: 'Segments', params: params).do_put

        resource 'Segment', data
      end
    end
  end
end
