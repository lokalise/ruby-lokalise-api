module Lokalise
  module Utils
    module Attributes
      def attributes_for(klass)
        @attributes ||= begin
          YAML.load_file(File.expand_path("../../data/attributes.json", __FILE__)).freeze
        end
        name = klass.name.snakecase
        # TODO: add checks for system_language and  other
        @attributes[name]
      end
    end
  end
end