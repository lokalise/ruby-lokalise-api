module Lokalise
  module Utils
    module AttributeHelpers
      UNIFIED_RESOURCES = %w[comment language].freeze

      # Returns the name of the API resource for the given class.
      # Most class names correspond to resource names (eg, `Project`, `Team`)
      # but some may differ (`ProjectComment` corresponds to `Comment` resource).
      # The resource name is in lowercase, with underscores as separators.
      def data_key_for(model_class, plural = false)
        data_key = if Module.const_defined? "Lokalise::Resources::#{model_class}::DATA_KEY"
                     Module.const_get "Lokalise::Resources::#{model_class}::DATA_KEY"
                   else
                     model_class
                   end.snakecase

        return data_key unless plural

        data_key + 's'
      end

      # Loads attributes for the given resource based on its name
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
