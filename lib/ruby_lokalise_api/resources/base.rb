# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Base
      using RubyLokaliseApi::Utils::StringUtils

      extend RubyLokaliseApi::Request
      extend RubyLokaliseApi::Utils::AttributeHelpers
      include RubyLokaliseApi::Utils::AttributeHelpers
      extend RubyLokaliseApi::Utils::EndpointHelpers

      attr_reader :raw_data, :project_id, :client, :path, :branch, :user_id, :team_id, :key_id

      # Initializes a new resource based on the response.
      # `endpoint_generator` is used in cases when a new instance is generated
      # from a different resource. For example, restoring from a snapshot
      # creates a totally different project which should have a new path.
      #
      # @param response [Hash]
      # @param endpoint_generator [Proc] Generate proper paths for certain resources
      # @return [RubyLokaliseApi::Resources::Base]
      def initialize(response, endpoint_generator = nil)
        populate_attributes_for response['content']
        extract_common_attributes_for response['content']
        @client = response['client']
        @path = infer_path_from response, endpoint_generator
      end

      class << self
        # Dynamically adds attribute readers for each inherited class.
        # Attributes are defined in the `data/attributes.json` file.
        # Also sets the `ATTRIBUTES` constant to assign values to each attribute later when
        # the response arrives from the API
        def inherited(subclass)
          klass_attributes = attributes_for subclass
          subclass.class_exec do
            const_set :ATTRIBUTES, klass_attributes
            attr_reader(*klass_attributes)
          end
          super
        end

        # Defines CRUD instance methods. In the simplest case it delegates work to the
        # class method. In more complex case it is possible to specify sub-path and the
        # class method name to call.
        # Usage: `supports :update, :destroy, [:complex_method, '/sub/path', :update]`
        def supports(*methods)
          methods.each do |m_data|
            # `method_name` - the method that the resource should support
            # `sub_path` - a string that has to be appended to a base path
            # `c_method` - method name to delegate the work to
            method_name, sub_path, c_method =
              m_data.is_a?(Array) ? m_data : [m_data, '', m_data]

            define_method method_name do |params = {}|
              path = instance_variable_get(:@path)
              # If there's a sub_path which is a string,
              # preserve the initial path to allow further chaining
              params = params.merge(_initial_path: path) if sub_path
              self.class.send c_method, instance_variable_get(:@client),
                              path + sub_path, params
            end
          end
        end

        # Fetches a single record
        def find(client, path, params = {})
          new get(path, client, prepare_params(params))
        end

        # Creates one or multiple records
        def create(client, path, params)
          response = post path, client, prepare_params(params)
          object_from response, params
        end

        # Updates one or multiple records
        def update(client, path, params)
          response = put path, client, prepare_params(params)
          object_from response, params
        end

        # Destroys records by given ids
        def destroy(client, path, params = {})
          delete(path, client, prepare_params(params))['content']
        end

        private

        # Filters out internal attributes that should not be sent to Lokalise
        def prepare_params(params)
          filter_attrs = %i[_initial_path]
          params.reject { |key, _v| filter_attrs.include?(key) }
        end

        # Instantiates a new resource or collection based on the given response
        def object_from(response, params)
          model_class = name.base_class_name
          data_key_plural = data_key_for model_class: model_class, plural: true
          # Preserve the initial path to allow chaining
          response['path'] = params.delete(:_initial_path) if params.key?(:_initial_path)

          if response['content'].key?(data_key_plural)
            produce_collection model_class, response, params
          else
            produce_resource model_class, response
          end
        end

        def produce_resource(model_class, response)
          content = response['content']
          data_key_singular = data_key_for model_class: model_class
          if content.key? data_key_singular
            data = content.delete data_key_singular
            content.merge! data
          end

          new response
        end

        def produce_collection(model_class, response, params)
          Module.const_get("RubyLokaliseApi::Collections::#{model_class}").new(response, params)
        end
      end

      # Generates path for the individual resource based on the path for the collection
      def infer_path_from(response, endpoint_generator = nil)
        id_key = id_key_for self.class.name.base_class_name
        data_key = data_key_for model_class: self.class.name.base_class_name

        path_with_id response, id_key, data_key, endpoint_generator
      end

      def path_with_id(response, id_key, data_key, endpoint_generator = nil)
        # Some resources do not have ids at all
        return unless response['content'] && (response['content'].key?(id_key) || response['content'].key?(data_key))

        # ID of the resource
        id = id_from response, id_key, data_key

        # If `endpoint_generator` is present, generate a new path
        # based on the fetched id
        if endpoint_generator
          path = endpoint_generator.call project_id, id
          return path.remove_trailing_slash
        end

        path = response['path'] || response['base_path']
        # If path already has id - just return it
        return path if path.match?(/#{id}\z/)

        # Otherwise this looks like a collection path, so append the resource id to it
        path.remove_trailing_slash + "/#{id}"
      end

      def id_from(response, id_key, data_key)
        # Content may be `{"project_id": '123', ...}` or {"snapshot": {"snapshot_id": '123', ...}}
        # Sometimes there is an `id_key` but it has a value of `null`
        # (for example when we do not place the actual order but only check its price).
        # In rare cases the actual identifier does not have an "_id" suffix
        # (for segments that have "segment_number" field instead)
        # Therefore we must explicitly check if the key is present
        content = response['content']
        return content[id_key] if content.respond_to?(:key?) && content&.key?(id_key)

        content[data_key][id_key]
      end

      # Store all resources attributes under the corresponding instance variables.
      # `ATTRIBUTES` is defined inside resource-specific classes
      def populate_attributes_for(content)
        return unless content

        data_key = data_key_for model_class: self.class.name.base_class_name

        self.class.const_get(:ATTRIBUTES).each do |attr|
          value = if content.key?(data_key) && content[data_key].is_a?(Hash)
                    content[data_key][attr]
                  else
                    content[attr]
                  end

          instance_variable_set "@#{attr}", value
        end
      end

      # Extracts all common attributes that resources have.
      # Some of them may be absent in certain cases.
      # rubocop:disable Naming/MemoizedInstanceVariableName
      def extract_common_attributes_for(content)
        return unless content

        @raw_data = content
        @project_id ||= content['project_id']
        @user_id ||= content['user_id']
        @team_id ||= content['team_id']
        @key_id ||= content['key_id']
        @branch ||= content['branch']
      end
      # rubocop:enable Naming/MemoizedInstanceVariableName
    end
  end
end
