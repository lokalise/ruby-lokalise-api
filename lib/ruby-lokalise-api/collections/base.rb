module Lokalise
  module Collections
    class Base
      extend Lokalise::Request
      extend Lokalise::Utils::AttributeHelpers
      include Lokalise::Utils::AttributeHelpers
      extend Lokalise::Utils::EndpointHelpers

      attr_reader :total_pages, :total_results, :results_per_page, :current_page, :collection,
                  :project_id, :team_id, :request_params, :client, :path

      # Initializes a new collection based on the response
      #
      # @param response [Hash]
      # @param params [Hash]
      # @return [Lokalise::Collections::Base]
      def initialize(response, params = {})
        produce_collection_for response
        populate_pagination_data_for response
        # Project and team id may not be present in some cases
        @project_id = response['content']['project_id']
        @team_id = response['content']['team_id']
        @request_params = params
        @client = response['client']
        @path = response['path']
      end

      class << self
        # Performs a batch query fetching multiple records
        def all(client, path, params = {})
          new get(path, client, params),
              params
        end
      end

      # @return [Boolean]
      def next_page?
        @current_page.positive? && @current_page < @total_pages
      end

      # @return [Boolean]
      def last_page?
        !next_page?
      end

      # @return [Boolean]
      def prev_page?
        @current_page > 1
      end

      # @return [Boolean]
      def first_page?
        !prev_page?
      end

      def next_page
        return nil if last_page?

        fetch_page @current_page + 1
      end

      def prev_page
        return nil if first_page?

        fetch_page @current_page - 1
      end

      private

      def populate_pagination_data_for(response)
        @total_results = response['x-pagination-total-count'].to_i
        @total_pages = response['x-pagination-page-count'].to_i
        @results_per_page = response['x-pagination-limit'].to_i
        @current_page = response['x-pagination-page'].to_i
      end

      def fetch_page(page_num)
        self.class.all @client,
                       @path,
                       @request_params.merge(page: page_num)
      end

      # Dynamically produces collection of resources based on the given response
      # Collection example: `{ "content": {"comments": [ ... ]} }`
      def produce_collection_for(response)
        model_class = self.class.name.base_class_name
        data_key_plural = data_key_for model_class, true

        # Fetch collection data and instantiate an individual resource for each object
        # We also preserve the `client` to be able to chain API methods later
        @collection = response['content'][data_key_plural].collect do |raw_model|
          Module.const_get("Lokalise::Resources::#{model_class}").new 'content' => raw_model,
                                                                      'client' => response['client'],
                                                                      'base_path' => response['path']
        end
      end
    end
  end
end
