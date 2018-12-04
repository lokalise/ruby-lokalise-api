module Lokalise
  class Client
    def screenshots(project_id, params = {})
      Lokalise::Collections::Screenshot.all @token, params, project_id
    end

    def screenshot(project_id, screenshot_id)
      Lokalise::Resources::Screenshot.find @token, project_id, screenshot_id
    end

    def create_screenshots(project_id, params = {})
      Lokalise::Resources::Screenshot.create @token, project_id, params, :screenshots
    end

    def update_screenshot(project_id, screenshot_id, params = {})
      Lokalise::Resources::Screenshot.update @token, project_id, screenshot_id, params
    end

    def delete_screenshot(project_id, screenshot_id)
      Lokalise::Resources::Screenshot.destroy @token, project_id, screenshot_id
    end
  end
end
