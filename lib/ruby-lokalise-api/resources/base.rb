module Lokalise
  module Resources
    class Base
      extend Lokalise::Request
      extend Lokalise::Utils::Attributes

      attr_reader :raw_data, :project_id

      def initialize(response)
        # Store all attributes under instance variables
        # ATTRIBUTES is defined inside model-specific classes
        data_key = if self.class.const_defined? :DATA_KEY
                     self.class.const_get :DATA_KEY
                   else
                     self.class.name.base_class_name
                   end.snakecase

        self.class.const_get(:ATTRIBUTES).each do |attr|
          value = if response['content'].key?(data_key) && response['content'][data_key].is_a?(Hash)
                    response['content'][data_key][attr]
                  else
                    response['content'][attr]
                  end

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
          model_class = name.base_class_name
          data_key = if const_defined? :DATA_KEY
                       const_get :DATA_KEY
                     else
                       model_class
                     end
          if r['content'].key?(data_key.snakecase + 's')
            Module.const_get("Lokalise::Collections::#{model_class}").new r, self.class
          else
            new r
          end
        end

        def update(token, endpoint_ids, resource_id, params, object_key = nil)
          r = put("#{endpoint(*endpoint_ids)}/#{resource_id}",
                  token,
                  body_from(params, object_key))

          model_class = name.base_class_name
          data_key = if const_defined? :DATA_KEY
                       const_get :DATA_KEY
                     else
                       model_class
                     end
          if r['content'].key?(data_key.snakecase + 's')
            Module.const_get("Lokalise::Collections::#{model_class}").new r, self.class
          else
            new r
          end
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
      end
    end
  end
end
