# frozen_string_literal: true

module Lokalise
  module Resources
    class File < Base
      class << self
        def download(client, path, params)
          post(path, client, params)['content']
        end

        def upload(client, path, params)
          # handle both upload mechanisms
          # sync upload is deprecated and will be removed by June-July
          klass = Lokalise::Resources::QueuedProcess
          if params[:queue] || params['queue']
            klass.new post(path, client, params),
                      ->(project_id, id) { klass.endpoint(project_id, id) }
          else
            post(path, client, params)['content']
          end
        end

        def endpoint(project_id, action = '')
          path_from projects: project_id,
                    files: action
        end
      end
    end
  end
end
