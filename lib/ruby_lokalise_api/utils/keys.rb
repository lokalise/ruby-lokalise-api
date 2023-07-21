# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Keys
      using RubyLokaliseApi::Utils::Strings

      # Reads DATA_KEY for resources. DATA_KEY specifies the name of the key
      # in the API response that contains the actual data
      def data_key_for(klass:)
        key = if Module.const_defined? "RubyLokaliseApi::Resources::#{klass}::DATA_KEY"
                Module.const_get "RubyLokaliseApi::Resources::#{klass}::DATA_KEY"
              else
                klass
              end

        key.snakecase
      end

      # Reads DATA_KEY for collections. DATA_KEY specifies the name of the key
      # in the API response that contains the actual data
      def collection_key_for(klass:)
        key = if Module.const_defined?("RubyLokaliseApi::Collections::#{klass}::DATA_KEY")
                Module.const_get("RubyLokaliseApi::Collections::#{klass}::DATA_KEY")
              else
                klass
              end

        key.snakecase
      end
    end
  end
end
