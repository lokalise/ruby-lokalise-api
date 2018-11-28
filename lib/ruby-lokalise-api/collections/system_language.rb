module Lokalise
  module Collections
    class SystemLanguage < Base
      private

      def self.endpoint(*_args)
        'system/languages'
      end
    end
  end
end