# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Jwt < Base
      class << self
        def endpoint(project_id, *_args)
          path_from projects: project_id, tokens: ''
        end
      end
    end
  end
end
