# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Teams
      # Returns teams
      #
      # @see https://developers.lokalise.com/reference/list-all-teams
      # @return [RubyLokaliseApi::Collections::Teams]
      # @param req_params [Hash]
      def teams(req_params = {})
        name = 'Teams'
        params = { req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end
    end
  end
end
