module Lokalise
  module Collections
    class Project < Base
      class << self
        def languages(token, project_id, params = {})
          load_collection "#{endpoint}/#{project_id}/languages", token, params
        end

        private

        def endpoint(*_args)
          'projects'
        end
      end
    end
  end
end
