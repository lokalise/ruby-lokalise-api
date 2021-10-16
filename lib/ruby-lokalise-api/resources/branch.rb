# frozen_string_literal: true

module Lokalise
  module Resources
    class Branch < Base
      supports :update, :destroy, [:reload_data, '', :find]

      def merge(params = {})
        klass = self.class
        klass.merge @client, klass.endpoint(project_id, branch_id, :merge), params
      end

      class << self
        def merge(client, path, params, *_args)
          post(path, client, params)['content']
        end

        def endpoint(project_id, branch_id = nil, action = nil)
          params = {projects: project_id,
                    branches: branch_id}

          params[:merge] = '' if action == :merge

          path_from params
        end
      end
    end
  end
end
