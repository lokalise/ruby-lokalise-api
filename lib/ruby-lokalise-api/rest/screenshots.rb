module Lokalise
  class Client
    def screenshots(project_id, params = {})
      Lokalise::Collections::Screenshot.all self, params, project_id
    end

    def screenshot(project_id, screenshot_id)
      Lokalise::Resources::Screenshot.find self, project_id, screenshot_id
    end

    def create_screenshots(project_id, params = {})
      Lokalise::Resources::Screenshot.create self, project_id, params, :screenshots
    end

    def update_screenshot(project_id, screenshot_id, params = {})
      Lokalise::Resources::Screenshot.update self, project_id, screenshot_id, params
    end

    def delete_screenshot(project_id, screenshot_id)
      Lokalise::Resources::Screenshot.destroy self, project_id, screenshot_id
    end
  end
end
