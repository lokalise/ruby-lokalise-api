# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Snapshot < Base
      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'snapshots']
        end
      end
    end
  end
end
