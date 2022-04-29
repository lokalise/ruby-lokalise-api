# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class KeyComment < Base
      class << self
        def endpoint(project_id, key_id, *_args)
          path_from projects: project_id,
                    keys: [key_id, 'comments']
        end
      end
    end
  end
end
