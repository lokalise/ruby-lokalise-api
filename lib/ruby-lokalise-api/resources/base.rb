module Lokalise
  module Resources
    class Base
      extend Lokalise::Request
      extend Lokalise::Utils::Attributes

      attr_reader :raw_data, :project_id

      def initialize(response)
        # Store all attributes under instance variables
        # ATTRIBUTES is defined inside model-specific classes
        data_key = self.class.const_get(:DATA_KEY).snakecase

        self.class.const_get(:ATTRIBUTES).each do |attr|
          value = response['content'].key?(data_key) ?
                    response['content'][data_key][attr] :
                    response['content'][attr]

          instance_variable_set "@#{attr}", value
        end

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
          r = post(endpoint(*endpoint_ids),
                   token,
                   body_from(params, object_key))
          data_key = if self.const_defined? :DATA_KEY
                       self.const_get :DATA_KEY
                     else
                       self.name.base_class_name
                     end
          if r['content'].key?(data_key.snakecase + 's')
            Module.const_get("Lokalise::Collections::#{data_key}").new r, self.class
          else
            new r
          end
        end

        def update(token, endpoint_ids, resource_id, params, object_key = nil)
          new put("#{endpoint(*endpoint_ids)}/#{resource_id}",
                  token,
                  body_from(params, object_key))
        end

        # Destroys records by given ids. resource_id may be a string or a hash with an array of ids
        def destroy(token, endpoint_ids, resource_id)
          if resource_id.is_a?(Hash)
            delete path, token, resource_id
          else
            delete "#{endpoint(*endpoint_ids)}/#{resource_id}",
                   token
          end
        end

        private

        # Converts `params` to hash with arrays under the `object_key` key
        # Used in bulk operations
        def body_from(params, object_key)
          return params unless object_key

          params = [params] unless params.is_a?(Array)
          Hash[object_key, params]
        end
      end
    end
  end
end
