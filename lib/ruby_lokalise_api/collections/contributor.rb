# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Contributor < Base
      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'contributors']
        end
      end
    end
  end
end
