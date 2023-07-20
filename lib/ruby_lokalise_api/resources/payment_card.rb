# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class PaymentCard < Base
      MAIN_PARAMS = %i[card_id].freeze
      no_support_for %i[update]
    end
  end
end
