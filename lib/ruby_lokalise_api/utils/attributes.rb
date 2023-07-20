# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Attributes
      using RubyLokaliseApi::Utils::Strings
      using RubyLokaliseApi::Utils::Classes

      private

      UNIFIED_RESOURCES = %w[comment].freeze

      # Loads attributes for the given resource based on its name
      #
      # @return [Array<String>]
      def attributes_for(klass, filename)
        @attributes ||= YAML.load_file(File.expand_path("../data/#{filename}", __dir__)).freeze

        name = unify klass.base_name.snakecase

        @attributes.key?(name) ? @attributes[name] : @attributes["#{name}s"]
      end

      # Unify some resources' names (eg, `ProjectComment` and `KeyComment` have the same
      # attributes which are stored under `comment`)
      #
      # @return [String]
      def unify(name)
        UNIFIED_RESOURCES.each do |u_a|
          return u_a if name.match?(/#{u_a}/)
        end

        name
      end
    end
  end
end
