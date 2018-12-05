module Lokalise
  module Collections
    class Base
      extend Lokalise::Request

      attr_reader :raw_data, :total_pages, :total_results, :results_per_page, :current_page, :collection

      def initialize(response, *_args)
        model_class = self.class.name.base_class_name
        data_key = if Module.const_defined? "Lokalise::Resources::#{model_class}::DATA_KEY"
                     Module.const_get("Lokalise::Resources::#{model_class}::DATA_KEY")
                   else
                     model_class
                   end

        @collection = response['content'][data_key.snakecase + 's'].collect do |raw_model|
          Module.const_get("Lokalise::Resources::#{model_class}").new 'content' => raw_model
        end

        # @raw_data = response['content']
        @total_results = response['x-pagination-total-count'].to_i
        @total_pages = response['x-pagination-page-count'].to_i
        @results_per_page = response['x-pagination-limit'].to_i
        @current_page = response['x-pagination-page'].to_i
      end

      class << self
        def all(token, params = {}, *ids)
          new get(endpoint(*ids), token, params)
        end
      end
    end
  end
end
