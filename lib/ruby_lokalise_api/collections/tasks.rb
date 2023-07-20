# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Tasks < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::TasksEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Task
    end
  end
end
