# frozen_string_literal: true

module RubyLokaliseApi
  # Basic utilitiy methods
  module Utils
    module Classes
      refine Object do
        # Extracts the base name of a class, removing any module nesting.
        #
        # @return [String] The base class name
        def base_name
          name.split('::').last
        end

        # Converts the object to an array, unless it is already an array.
        #
        # @return [Array] The object wrapped in an array if not already an array
        def to_array
          is_a?(Array) ? self : [self]
        end

        # Converts the object to an array, then places this array inside a hash
        # under the provided key.
        #
        # @param key [Symbol, String] The key under which to place the array
        # @return [Hash] The hash with the array under the provided key
        def to_array_obj(key)
          return self if is_a?(Hash) && (key?(key) || key?(key.to_s))

          { key => to_array }
        end
      end
    end
  end
end
