# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class OAuth2RefreshedToken < Base
      no_support_for %i[update destroy reload_data]
    end
  end
end
