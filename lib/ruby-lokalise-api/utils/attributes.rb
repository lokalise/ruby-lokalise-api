module Lokalise
  module Utils
    module Attributes
      UNIFIED_RESOURCES = %w[comment].freeze

      def attributes_for(klass)
        @attributes ||= begin
          YAML.load_file(File.expand_path('../data/attributes.json', __dir__)).freeze
        end

        name = unify klass.name.snakecase
        @attributes[name]
      end

      private

      # Unify some resources' names (eg, `ProjectComment` and `KeyComment` have the same attributes which are stored under `comment`)
      def unify(name)
        UNIFIED_RESOURCES.each do |u_a|
          return u_a if name.match?(/#{u_a}/)
        end

        name
      end
    end
  end
end
