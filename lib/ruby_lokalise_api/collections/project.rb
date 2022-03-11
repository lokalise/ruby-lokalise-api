# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Project < Base
      class << self
        def endpoint(*_args)
          path_from projects: nil
        end
      end
    end
  end
end
