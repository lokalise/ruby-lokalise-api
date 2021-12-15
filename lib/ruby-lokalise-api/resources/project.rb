# frozen_string_literal: true

module Lokalise
  module Resources
    class Project < Base
      ID_KEY = 'project_id'
      supports :update, :destroy, [:reload_data, '', :find]

      def empty
        self.class.empty @client, "#{@path}/empty"
      end

      class << self
        def empty(client, path, *_args)
          put(path, client)['content']
        end

        def endpoint(project_id = nil, action = nil)
          path_from projects: [project_id, action]
        end
      end
    end
  end
end
