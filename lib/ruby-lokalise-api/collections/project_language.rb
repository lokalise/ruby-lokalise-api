module Lokalise
  module Collections
    class ProjectLanguage < Base

      private

      def self.endpoint(project_id)
        "projects/#{project_id}/languages"
      end
    end
  end
end