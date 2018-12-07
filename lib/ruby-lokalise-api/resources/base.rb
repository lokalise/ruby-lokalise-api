module Lokalise
  module Resources
    class Base
      extend Lokalise::Request
      extend Lokalise::Utils::AttributeHelpers
      include Lokalise::Utils::AttributeHelpers

      attr_reader :raw_data, :project_id

      def initialize(response)
        populate_attributes_for response['content']

        @raw_data = response['content']
        @project_id = response['content']['project_id']
      end

      class << self
        def inherited(subclass)
          klass_attributes = attributes_for subclass
          subclass.const_set :ATTRIBUTES, klass_attributes
          attr_reader(*klass_attributes)
          super
        end

        def find(token, endpoint_ids, resource_id = '', params = {})
          new get("#{endpoint(*endpoint_ids)}/#{resource_id}",
                  token,
                  params)
        end

        def create(token, endpoint_ids, params, object_key = nil)
          response = post(endpoint(*endpoint_ids),
                          token,
                          body_from(params, object_key))

          object_from response
        end

        def update(token, endpoint_ids, resource_id, params, object_key = nil)
          response = put("#{endpoint(*endpoint_ids)}/#{resource_id}",
                         token,
                         body_from(params, object_key))

          object_from response
        end

        # Destroys records by given ids. resource_id may be a string or a hash with an array of ids
        def destroy(token, endpoint_ids, resource_id)
          if resource_id.is_a?(Hash)
            delete path, token, resource_id
          else
            delete "#{endpoint(*endpoint_ids)}/#{resource_id}", token
          end['content']
        end

        private

        # Converts `params` to hash with arrays under the `object_key` key
        # Used in bulk operations
        def body_from(params, object_key)
          return params unless object_key

          params = [params] unless params.is_a?(Array)
          Hash[object_key, params]
        end

        def object_from(response)
          model_class = name.base_class_name
          data_key_plural = data_key_for model_class, true

          if response['content'].key? data_key_plural
            Module.const_get("Lokalise::Collections::#{model_class}").new response
          else
            new response
          end
        end
      end

      private

      # Store all resources attributes under instance variables.
      # ATTRIBUTES is defined inside model-specific classes
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
