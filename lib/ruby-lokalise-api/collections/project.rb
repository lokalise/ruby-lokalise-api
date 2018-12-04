module Lokalise
  module Collections
    class Project < Base
      class << self
        private

        def endpoint(*_args)
          'projects'
        end
      end
    end
  end
end
