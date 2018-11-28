module Lokalise
  module Collections
    class Team < Base
      class << self
        private

        def endpoint(*_args)
          'teams'
        end
      end
    end
  end
end
