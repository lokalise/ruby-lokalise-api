module Lokalise
  module Utils
    module AttributeHelpers
      UNIFIED_RESOURCES = %w[comment language].freeze

      # Returns the name of the API resource for the given class.
      # Most class names correspond to resource names (eg, `Project`, `Team`)
      # but some may differ (`ProjectComment` corresponds to `Comment` resource).
      # The resource name is in lowercase, with underscores as separators.
      #
      # @return [String]
      # @param model_class [String]
      # @param plural [Boolean] Should the returned value be pluralized?
      def data_key_for(model_class, plural = false, collection = false)
        data_key = get_key 'DATA_KEY', model_class, collection

        return data_key unless plural

        data_key + 's'
      end

      # Returns key used to determine resource id (for example `user_id` or `project_id`).
      # Most ids corresponds to resources' class names, but some may differ (for instance,
      # `Contributor` has  `user_id` attribute).
      #
      # @return [String]
      # @param model_class [String]
      def id_key_for(model_class)
        get_key('ID_KEY', model_class) + '_id'
      end

      # Loads attributes for the given resource based on its name
      #
      # @return [Array<String>]
      def attributes_for(klass)
        @attributes ||= begin
          YAML.load_file(File.expand_path('../data/attributes.json', __dir__)).freeze
        end

        name = unify klass.name.snakecase
        @attributes[name]
      end

      private

      def get_key(name, model_class, collection = false)
        if collection && Module.const_defined?("Lokalise::Collections::#{model_class}::#{name}")
          Module.const_get "Lokalise::Collections::#{model_class}::#{name}"
        elsif Module.const_defined? "Lokalise::Resources::#{model_class}::#{name}"
          Module.const_get "Lokalise::Resources::#{model_class}::#{name}"
        else
          model_class
        end.snakecase
      end

      # Unify some resources' names (eg, `ProjectComment` and `KeyComment` have the same attributes which are stored under `comment`)
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
