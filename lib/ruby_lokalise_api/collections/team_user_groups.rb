# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class TeamUserGroups < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::TeamUserGroupsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::TeamUserGroup
      DATA_KEY = 'user_groups'
    end
  end
end
