module Lokalise
  module Resources
    class Base
      extend Lokalise::Request

      attr_reader :content, :total_pages, :total_results,  :results_per_page, :current_page

      def initialize(response)
        @content = response['content']
        @total_results = response['x-pagination-total-count'].to_i
        @total_pages = response['x-pagination-page-count'].to_i
        @results_per_page = response['x-pagination-limit'].to_i
        @current_page = response['x-pagination-page'].to_i
      end

      private

      def self.load_record(path, token, id)
        new get(path + '/'  + id.to_s, token)
      end

      def self.load_collection(path, token, params)
        new get(path, token, params)
      end

      def self.create_record(path, token, params)
        new post(path, token, params)
      end

      def self.update_record(path, token, params = {})
        new put(path, token, params)
      end

      def self.destroy_record(path, token, id)
        new delete(path + '/'  + id.to_s, token)
      end
    end
  end
end