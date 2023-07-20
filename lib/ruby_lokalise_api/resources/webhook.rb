# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Webhook < Base
      MAIN_PARAMS = %i[project_id webhook_id].freeze

      delegate_call :regenerate_secret, :regenerate_webhook_secret
    end
  end
end
