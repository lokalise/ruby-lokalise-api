# frozen_string_literal: true

module RubyLokaliseApi
  # Base resource class. A resource is an individual object returned by the API
  module Resources
    class Base
      using RubyLokaliseApi::Utils::Classes
      extend RubyLokaliseApi::Utils::Attributes
      extend RubyLokaliseApi::Concerns::Unsupportable
      extend RubyLokaliseApi::Concerns::AttrsLoadable
      include RubyLokaliseApi::Concerns::HashAccessible
      include RubyLokaliseApi::Utils::Keys

      ATTRS_FILENAME = 'resource_attributes.yml'

      def initialize(response)
        @self_endpoint = response.endpoint

        populate_attrs_from response.content
      end

      # Updates the current resource
      def update(params)
        self.class.new reinit_endpoint(params).do_put
      end

      # Deletes the current resource
      def destroy
        RubyLokaliseApi::Generics::DeletedResource.new(
          reinit_endpoint.do_delete.content
        )
      end

      # Reloads the current resource with new values from the API
      def reload_data
        self.class.new reinit_endpoint.do_get
      end

      class << self
        # Delegates instance method calls to the client methods
        def delegate_call(from, to = nil)
          define_method(from) do |*args|
            @self_endpoint.client.send((to || from), *read_main_params.push(*args))
          end
        end
      end

      private

      def read_main_params
        self.class.const_get(:MAIN_PARAMS).to_array.map do |param|
          instance_variable_get :"@#{param}"
        end
      end

      def reinit_endpoint(req_params = {})
        @self_endpoint.reinitialize(query_params: read_main_params, req_params: req_params)
      end

      # Populates attributes from the response content
      def populate_attrs_from(content)
        return unless content

        data_key = data_key_for(klass: self.class.base_name)
        supported_attrs.each { |attrib| set_instance_variable(attrib, content, data_key) }
      end

      # Sets the instance variable for a given attribute
      def set_instance_variable(attrib, content, data_key)
        value = if content_key_exists?(content, data_key, attrib)
                  content[data_key][attrib]
                else
                  content[attrib]
                end

        instance_variable_set(:"@#{attrib}", value)
      end

      # Checks if the content contains the specified key
      def content_key_exists?(content, data_key, attrib)
        content.key?(data_key) && content[data_key].is_a?(Hash) && content[data_key].key?(attrib)
      end
    end
  end
end
