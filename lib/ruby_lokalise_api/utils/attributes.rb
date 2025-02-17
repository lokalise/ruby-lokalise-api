# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Attributes
      using RubyLokaliseApi::Utils::Strings
      using RubyLokaliseApi::Utils::Classes

      UNIFIED_RESOURCES = %w[comment].freeze

      private

      # Loads attributes for the given resource based on its name
      #
      # @return [Array<String>]
      def attributes_for(klass, filename)
        @attributes ||= load_attributes(filename)

        name = unify klass.base_name.snakecase

        @attributes[name] || @attributes["#{name}s"]
      end

      # Unify some resources' names (eg, `ProjectComment` and `KeyComment` have the same
      # attributes which are stored under `comment`)
      #
      # @return [String]
      def unify(name)
        UNIFIED_RESOURCES.find { |u_a| name.match?(/#{u_a}/) } || name
      end

      # Loads attributes from a YAML file
      #
      # @param filename [String] The filename to load attributes from
      # @return [Hash] The loaded attributes hash
      def load_attributes(filename)
        YAML.load_file(File.expand_path("../data/#{filename}", __dir__)).freeze
      end
    end
  end
end
