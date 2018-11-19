module Lokalise
  module Collections
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

      def self.load_collection(path, token, params)
        new get(path, token, params)
      end
    end
  end
end