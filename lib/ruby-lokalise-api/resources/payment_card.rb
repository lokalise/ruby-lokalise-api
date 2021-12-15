# frozen_string_literal: true

module Lokalise
  module Resources
    class PaymentCard < Base
      ID_KEY = 'card_id'
      supports :destroy, [:reload_data, '', :find]

      class << self
        def endpoint(card_id = nil)
          path_from payment_cards: card_id
        end
      end
    end
  end
end
