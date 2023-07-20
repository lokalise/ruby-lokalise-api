# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Strings
      refine String do
        # Initial code taken from Facets gem by Rubyworks
        # https://github.com/rubyworks/facets/blob/master/lib/core/facets/string/snakecase.rb
        def snakecase
          gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
            gsub(/([a-z\d])([A-Z])/, '\1_\2').
            tr('-', '_').
            gsub(/\s/, '_').
            gsub(/__+/, '_').
            downcase
        end
      end
    end
  end
end
