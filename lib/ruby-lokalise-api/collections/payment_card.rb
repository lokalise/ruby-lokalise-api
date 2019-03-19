module Lokalise
  module Collections
    class PaymentCard < Base
      class << self
        def endpoint(*_args)
          path_from payment_cards: nil
        end
      end
    end
  end
end
