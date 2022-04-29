# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Key < Base
      ID_KEY = 'key_id'
      supports :update, :destroy, [:reload_data, '', :find]

      class << self
        def endpoint(project_id, key_id = nil)
          path_from projects: project_id,
                    keys: key_id
        end
      end
    end
  end
end
