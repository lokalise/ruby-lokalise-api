# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Branches < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::BranchesEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Branch
      DATA_KEY = 'branches'
    end
  end
end
