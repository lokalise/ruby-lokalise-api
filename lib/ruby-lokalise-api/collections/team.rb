# frozen_string_literal: true

module Lokalise
  module Collections
    class Team < Base
      class << self
        def endpoint(*_args)
          path_from teams: nil
        end
      end
    end
  end
end
