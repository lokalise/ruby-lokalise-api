# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class TeamUsers < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::TeamUsersEndpoint
      RESOURCE = RubyLokaliseApi::Resources::TeamUser
    end
  end
end
