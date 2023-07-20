# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Projects < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::ProjectsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Project
    end
  end
end
