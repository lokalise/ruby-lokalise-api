# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Strings
      refine String do
        # Converts a string to snake_case format.
        # Original code inspired by the Facets gem by Rubyworks:
        # https://github.com/rubyworks/facets/blob/master/lib/core/facets/string/snakecase.rb
        def snakecase
          gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2'). # Handle acronyms like 'HTMLParser'
            gsub(/([a-z\d])([A-Z])/, '\1_\2').      # Handle camelCase to snake_case
            tr('-', '_').                           # Replace dashes with underscores
            gsub(/\s/, '_').                        # Replace spaces with underscores
            gsub(/__+/, '_').                       # Collapse multiple underscores
            downcase # Convert everything to lowercase
        end
      end
    end
  end
end
