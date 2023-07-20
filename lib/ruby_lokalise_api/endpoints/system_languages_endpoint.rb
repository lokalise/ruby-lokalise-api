# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class SystemLanguagesEndpoint < MainEndpoint
      private

      def base_query(*_args)
        {
          system: :languages
        }
      end
    end
  end
end
