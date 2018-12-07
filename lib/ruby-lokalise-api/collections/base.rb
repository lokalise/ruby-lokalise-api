module Lokalise
  module Collections
    class Base
      extend Lokalise::Request
      extend Lokalise::Utils::AttributeHelpers
      include Lokalise::Utils::AttributeHelpers

      attr_reader :raw_data, :total_pages, :total_results, :results_per_page, :current_page, :collection,
                  :project_id

      def initialize(response)
        produce_collection_for response['content']
        @total_results = response['x-pagination-total-count'].to_i
        @total_pages = response['x-pagination-page-count'].to_i
        @results_per_page = response['x-pagination-limit'].to_i
        @current_page = response['x-pagination-page'].to_i
        @project_id = response['content']['project_id']
      end

      class << self
        def all(token, params = {}, *ids)
          new get(endpoint(*ids), token, params)
        end
      end

      private

      def produce_collection_for(content)
        model_class = self.class.name.base_class_name
        data_key_plural = data_key_for model_class, true

        @collection = content[data_key_plural].collect do |raw_model|
          Module.const_get("Lokalise::Resources::#{model_class}").new 'content' => raw_model
        end
      end
    end
  end
end
