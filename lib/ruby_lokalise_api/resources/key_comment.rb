# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class KeyComment < Base
      DATA_KEY = 'Comment'
      ID_KEY = 'comment_id'
      supports :destroy, [:reload_data, '', :find]

      class << self
        def endpoint(project_id, key_id, comment_id = nil)
          path_from projects: project_id,
                    keys: key_id,
                    comments: comment_id
        end
      end
    end
  end
end
