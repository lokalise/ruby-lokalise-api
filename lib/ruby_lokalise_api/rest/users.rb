# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Users
      using RubyLokaliseApi::Utils::Classes

      # Returns basic user information
      #
      # @return [RubyLokaliseApi::Resources::SystUseremLanguages]
      # @param user_id [String, Integer]
      def user(user_id)
        params = { query: user_id }

        data = endpoint(name: 'Users', params: params).do_get

        resource 'User', data
      end
    end
  end
end
