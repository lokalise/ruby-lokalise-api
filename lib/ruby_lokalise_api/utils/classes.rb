# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Classes
      refine Object do
        # Turn `Module::Nested::ClassName` to just `ClassName`
        def base_name
          name.split('::').last
        end

        def to_array
          is_a?(Array) ? self : [self]
        end

        def to_array_obj(key)
          return self if is_a?(Hash) && (key?(key) || key?(key.to_s))

          { key => to_array }
        end
      end
    end
  end
end
