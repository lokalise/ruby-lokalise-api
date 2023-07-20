# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    # Base collection. Collection is an array of resources. The actual resources can be found
    # by calling the `.collection` method
    class Base
      include Enumerable
      extend Forwardable

      using RubyLokaliseApi::Utils::Classes
      extend RubyLokaliseApi::Utils::Attributes
      extend RubyLokaliseApi::Concerns::AttrsLoadable
      include RubyLokaliseApi::Utils::Keys

      ATTRS_FILENAME = 'collection_attributes.yml'

      def_delegators :collection, :[], :last, :each

      attr_reader :total_pages, :total_results, :results_per_page, :current_page,
                  :collection

      def initialize(response)
        @self_endpoint = response.endpoint

        populate_common_attrs_from response
        produce_collection_from response
      end

      # Tries to fetch the next page for paginated collection
      # Returns a new collection or nil if the next page is not available
      def next_page
        return nil if last_page?

        self.class.new(
          reinit_endpoint(
            override_req_params: { page: current_page + 1 }
          ).do_get
        )
      end

      # Tries to fetch the previous page for paginated collection
      # Returns a new collection or nil if the previous page is not available
      def prev_page
        return nil if first_page?

        self.class.new(
          reinit_endpoint(
            override_req_params: { page: current_page - 1 }
          ).do_get
        )
      end

      # Checks whether the next page is available
      # @return [Boolean]
      def next_page?
        current_page.positive? && current_page < total_pages
      end

      # Checks whether the current page is the last one
      # @return [Boolean]
      def last_page?
        !next_page?
      end

      # Checks whether the previous page is available
      # @return [Boolean]
      def prev_page?
        current_page > 1
      end

      # Checks whether the current page is the first one
      # @return [Boolean]
      def first_page?
        !prev_page?
      end

      private

      # This method is utilized to recreate an endpoint for the current collection
      def reinit_endpoint(req_params: @self_endpoint.req_params, override_req_params: {})
        @self_endpoint.reinitialize(
          req_params: req_params.merge(override_req_params)
        )
      end

      def populate_common_attrs_from(response)
        supported_attrs.each do |attrib|
          instance_variable_set "@#{attrib}", response.content[attrib]
        end

        headers = response.headers

        return unless headers.any?

        @total_results = headers[:'x-pagination-total-count']
        @total_pages = headers[:'x-pagination-page-count']
        @results_per_page = headers[:'x-pagination-limit']
        @current_page = headers[:'x-pagination-page']
      end

      def produce_collection_from(response)
        content = response.content
        return unless content

        data_key_plural = collection_key_for klass: self.class.base_name

        resources_data = content[data_key_plural]
        other_data = content.reject { |key, _| key == data_key_plural }

        @collection = build_collection resources_data, other_data
      end

      def build_collection(resources_data, other_data)
        resources_data.map do |raw_resource|
          self.class.const_get(:RESOURCE).new(resource_data(raw_resource, other_data))
        end
      end

      def resource_data(raw_resource, other_data)
        RubyLokaliseApi::Response.new(
          raw_resource.merge(other_data),
          resource_endpoint.new(
            @self_endpoint.client,
            query: query_for(raw_resource, other_data)
          )
        )
      end

      def query_for(raw_resource, other_data)
        main_params = self.class.const_get(:RESOURCE).const_get(:MAIN_PARAMS).to_array

        main_params.map do |param|
          other_data[param.to_s] || raw_resource[param.to_s] || nil
        end
      end

      def resource_endpoint
        klass = self.class

        klass.const_defined?(:RESOURCES_ENDPOINT) ? klass.const_get(:RESOURCES_ENDPOINT) : klass.const_get(:ENDPOINT)
      end
    end
  end
end
