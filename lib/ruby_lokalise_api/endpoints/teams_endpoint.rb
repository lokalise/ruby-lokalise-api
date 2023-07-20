# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class TeamsEndpoint < MainEndpoint
      private

      def base_query(*_args)
        [:teams]
      end
    end
  end
end
