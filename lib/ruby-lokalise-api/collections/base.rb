module Lokalise
  module Collections
    class Base
      extend Lokalise::Request
      extend Lokalise::Utils::AttributeHelpers
      include Lokalise::Utils::AttributeHelpers

      attr_reader :raw_data, :total_pages, :total_results, :results_per_page, :current_page, :collection,
                  :project_id, :team_id

      def initialize(response)
        produce_collection_for response
        @total_results = response['x-pagination-total-count'].to_i
        @total_pages = response['x-pagination-page-count'].to_i
        @results_per_page = response['x-pagination-limit'].to_i
        @current_page = response['x-pagination-page'].to_i
        # Project and team id may not be present in some cases
        @project_id = response['content']['project_id']
        @team_id = response['content']['team_id']
      end

      class << self
        # Performs a batch query fetching multiple records
        def all(client, params = {}, *ids)
          new get(endpoint(*ids), client, params)
        end
      end

      private

      # Dynamically produces collection of resources based on the given response
      # Collection example: `{ "content": {"comments": [ ... ]} }`
      def produce_collection_for(response)
        model_class = self.class.name.base_class_name
        data_key_plural = data_key_for model_class, true

        # Fetch collection data and instantiate an individual resource for each object
        # We also preserve the `client` to be able to chain API methods later
        @collection = response['content'][data_key_plural].collect do |raw_model|
          Module.const_get("Lokalise::Resources::#{model_class}").new 'content' => raw_model,
                                                                      'client' => response['client']
        end
      end
    end
  end
end
