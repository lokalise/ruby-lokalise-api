# frozen_string_literal: true

require 'json'

module RubyLokaliseApi
  module JsonHandler
    # JSON custom parser. Uses built-in JSON by default but can be overridden to any other parser

    # Converts Ruby object to JSON
    def custom_dump(obj)
      JSON.dump obj
    end

    # Converts JSON to Ruby object
    def custom_load(obj)
      JSON.parse obj
    end
  end
end
