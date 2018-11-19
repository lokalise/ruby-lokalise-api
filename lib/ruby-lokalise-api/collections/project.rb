module Lokalise
  module Collections
    class Project < Base
      ENDPOINT = 'projects'.freeze

      class << self
        def all(token, params = {})
          load_collection ENDPOINT, token, params
        end
      end
    end
  end
end