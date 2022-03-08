# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class File < Base
      class << self
        def download(client, path, params)
          post(path, client, params)['content']
        end

        def upload(client, path, params)
          klass = RubyLokaliseApi::Resources::QueuedProcess
          klass.new post(path, client, params),
                    ->(project_id, id) { klass.endpoint(project_id, id) }
        end

        def endpoint(project_id, action = '')
          path_from projects: project_id,
                    files: action
        end
      end
    end
  end
end