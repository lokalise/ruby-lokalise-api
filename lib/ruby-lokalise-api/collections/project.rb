module Lokalise
  module Collections
    class Project < Base
      def self.languages(token, project_id, params = {})
        load_collection "#{endpoint}/#{project_id}/languages", token, params
      end

      private

      def self.endpoint(*_args)
        'projects'
      end
    end
  end
end