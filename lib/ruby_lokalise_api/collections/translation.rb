# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Translation < Base
      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'translations']
        end
      end
    end
  end
end
