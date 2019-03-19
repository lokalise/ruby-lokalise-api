module Lokalise
  module Resources
    class PaymentCard < Base
      supports :destroy

      class << self
        def endpoint(card_id = nil)
          path_from payment_cards: card_id
        end
      end
    end
  end
end
