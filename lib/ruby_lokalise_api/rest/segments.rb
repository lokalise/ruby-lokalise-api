# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Segments
      # Returns all segments for the given key and language ISO code
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-list-all-segments-for-key-language-get
      # @return [RubyLokaliseApi::Collection::Segments<RubyLokaliseApi::Resources::Segment>]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param lang_iso [String]
      # @param params [Hash]
      def segments(project_id, key_id, lang_iso, params = {})
        c_r RubyLokaliseApi::Collections::Segment, :all, [project_id, key_id, lang_iso], params
      end

      # Returns a segment under a given number for the given key and language ISO code
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-retrieve-a-segment-for-key-language-get
      # @return [RubyLokaliseApi::Resources::Segment]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param lang_iso [String]
      # @params segment_number [Integer, String]
      # @param params [Hash]
      def segment(project_id, key_id, lang_iso, segment_number, params = {})
        c_r RubyLokaliseApi::Resources::Segment, :find, [project_id, key_id, lang_iso, segment_number], params
      end

      # Updates a segment under a given number for the given key and language ISO code
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-update-a-segment-post
      # @return [RubyLokaliseApi::Resources::Segment]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param lang_iso [String]
      # @params segment_number [Integer, String]
      # @param params [Hash]
      def update_segment(project_id, key_id, lang_iso, segment_number, params = {})
        c_r RubyLokaliseApi::Resources::Segment, :update, [project_id, key_id, lang_iso, segment_number], params
      end
    end
  end
end
