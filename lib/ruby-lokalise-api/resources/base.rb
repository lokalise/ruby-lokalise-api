module Lokalise
  module Resources
    class Base
      extend Lokalise::Request
      extend Lokalise::Utils::AttributeHelpers
      include Lokalise::Utils::AttributeHelpers
      extend Lokalise::Utils::EndpointHelpers

      attr_reader :raw_data, :project_id, :client, :path

      # Initializes a new resource based on the response
      #
      # @param response [Hash]
      # @return [Lokalise::Resources::Base]
      def initialize(response)
        populate_attributes_for response['content']

        @raw_data = response['content']
        @project_id = response['content']['project_id']
        @client = response['client']
        @path = response['path']
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
        def find(client, path, params = {})
          new get(path, client, params)
        end

        # Creates one or multiple records
        def create(client, path, params)
          response = post path, client, params

          object_from response, params
        end

        # Updates one or multiple records
        def update(client, path, params)
          response = put path, client, params

          object_from response, params
        end

        # Destroys records by given ids
        def destroy(client, path, params = {})
          delete(path, client, params)['content']
        end

        private

        # Instantiates a new resource or collection based on the given response
        def object_from(response, params)
          model_class = name.base_class_name
          data_key_plural = data_key_for model_class, true

          if response['content'].key? data_key_plural
            Module.const_get("Lokalise::Collections::#{model_class}").new response,
                                                                          params
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
