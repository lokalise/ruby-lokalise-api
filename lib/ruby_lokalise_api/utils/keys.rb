# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Keys
      using RubyLokaliseApi::Utils::Strings

      # Retrieves the DATA_KEY for resources.
      # DATA_KEY specifies the key in the API response containing the actual data.
      #
      # @param klass [Class] The class of the resource
      # @return [String] The snake-cased DATA_KEY
      def data_key_for(klass:)
        retrieve_data_key("RubyLokaliseApi::Resources::#{klass}::DATA_KEY", klass)
      end

      # Retrieves the DATA_KEY for collections.
      # DATA_KEY specifies the key in the API response containing the actual data.
      #
      # @param klass [Class] The class of the collection
      # @return [String] The snake-cased DATA_KEY
      def collection_key_for(klass:)
        retrieve_data_key("RubyLokaliseApi::Collections::#{klass}::DATA_KEY", klass)
      end

      private

      # Helper method to retrieve the DATA_KEY for a given class.
      #
      # @param constant_path [String] The constant path to check
      # @param fallback [Class] The fallback class if the constant isn't defined
      # @return [String] The snake-cased key
      def retrieve_data_key(constant_path, fallback)
        key = if Module.const_defined?(constant_path)
                Module.const_get(constant_path)
              else
                fallback
              end

        key.snakecase
      end
    end
  end
end
