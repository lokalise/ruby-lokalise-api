# frozen_string_literal: true

module RubyLokaliseApi
  # Basic utilitiy methods
  module Utils
    module Classes
      refine Object do
        # Turn `Module::Nested::ClassName` to just `ClassName`
        def base_name
          name.split('::').last
        end

        # Converts object to array unless it is already an array
        def to_array
          is_a?(Array) ? self : [self]
        end

        # Converts object to array and then places this array
        # inside hash under the provided key
        def to_array_obj(key)
          return self if is_a?(Hash) && (key?(key) || key?(key.to_s))

          { key => to_array }
        end
      end
    end
  end
end
