module Lokalise
  module Collections
    class SystemLanguage < Base
      class << self
        private

        def endpoint(*_args)
          'system/languages'
        end
      end
    end
  end
end
