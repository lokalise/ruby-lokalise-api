# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Jwt < Base
      class << self
        def endpoint(*_args)
          path_from 'jwt-tokens': 'ota'
        end
      end
    end
  end
end
