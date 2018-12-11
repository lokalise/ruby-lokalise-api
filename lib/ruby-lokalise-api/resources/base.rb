module Lokalise
  module Resources
    class Base
      extend Lokalise::Request
      extend Lokalise::Utils::AttributeHelpers
      include Lokalise::Utils::AttributeHelpers

      attr_reader :raw_data, :project_id, :client

      # Initializes a new resource based on the response
      #
      # @param response [Hash]
      # @return [Lokalise::Resources::Base]
      def initialize(response)
        populate_attributes_for response['content']

        @raw_data = response['content']
        @project_id = response['content']['project_id']
        @client = response['client']
      end

      class << self
        # Dynamically add attribute readers for each inherited class.
        # Attributes are defined in the `data/attributes.json` file.
        # Also set the `ATTRIBUTES` constant to assign values to each attribute later when
        # the response arrives from the API
        def inherited(subclass)
          klass_attributes = attributes_for subclass
          subclass.class_exec do
            const_set :ATTRIBUTES, klass_attributes
            attr_reader(*klass_attributes)
          end
          super
        end

        # Fetches a single record
        def find(client, endpoint_ids, resource_id = '', params = {})
          new get("#{endpoint(*endpoint_ids)}/#{resource_id}",
                  client,
                  params)
        end

        # Creates one or multiple records
        def create(client, endpoint_ids, params, object_key = nil)
          response = post(endpoint(*endpoint_ids),
                          client,
                          body_from(params, object_key))

          object_from response, params, endpoint_ids
        end

        # Updates one or multiple records
        def update(client, endpoint_ids, resource_id, params, object_key = nil)
          response = put("#{endpoint(*endpoint_ids)}/#{resource_id}",
                         client,
                         body_from(params, object_key))

          object_from response, params, endpoint_ids
        end

        # Destroys records by given ids
        #
        # @param client [Lokalise::Client]
        # @return [Hash]
        # @param endpoint_ids [String, Integer, Array]
        # @param resource_id [String, Integer, Hash<Array>]
        def destroy(client, endpoint_ids, resource_id)
          path = endpoint(*endpoint_ids).to_s
          if resource_id.is_a?(Hash)
            delete path, client, resource_id
          else
            delete "#{path}/#{resource_id}", client
          end['content']
        end

        private

        # Converts `params` to hash with arrays under the `object_key` key.
        # Used in bulk operations
        #
        # @return [Hash]
        def body_from(params, object_key)
          return params unless object_key

          params = [params] unless params.is_a?(Array)
          Hash[object_key, params]
        end

        # Instantiates a new resource or collection based on the given response
        def object_from(response, params, endpoint_ids)
          model_class = name.base_class_name
          data_key_plural = data_key_for model_class, true

          if response['content'].key? data_key_plural
            Module.const_get("Lokalise::Collections::#{model_class}").new response,
                                                                          params,
                                                                          endpoint_ids
          else
            new response
          end
        end
      end

      private

      # Store all resources attributes under the corresponding instance variables.
      # `ATTRIBUTES` is defined inside resource-specific classes
      def populate_attributes_for(content)
        data_key = data_key_for self.class.name.base_class_name

        self.class.const_get(:ATTRIBUTES).each do |attr|
          value = if content.key?(data_key) && content[data_key].is_a?(Hash)
                    content[data_key][attr]
                  else
                    content[attr]
                  end

          instance_variable_set "@#{attr}", value
        end
      end
    end
  end
end
