# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class SystemLanguage < Base
      class << self
        def endpoint(*_args)
          path_from system: 'languages'
        end
      end
    end
  end
end
