# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Screenshot < Base
      ID_KEY = 'screenshot_id'
      supports :update, :destroy, [:reload_data, '', :find]

      class << self
        def endpoint(project_id, screenshot_id = nil)
          path_from projects: project_id,
                    screenshots: screenshot_id
        end
      end
    end
  end
end
