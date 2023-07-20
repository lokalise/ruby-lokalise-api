# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Keys
      using RubyLokaliseApi::Utils::Strings

      def data_key_for(klass:)
        key = if Module.const_defined? "RubyLokaliseApi::Resources::#{klass}::DATA_KEY"
                Module.const_get "RubyLokaliseApi::Resources::#{klass}::DATA_KEY"
              else
                klass
              end

        key.snakecase
      end

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
