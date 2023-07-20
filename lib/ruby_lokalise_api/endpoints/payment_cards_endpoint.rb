# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class PaymentCardsEndpoint < MainEndpoint
      private

      def base_query(card_id = nil, *_args)
        {
          payment_cards: card_id
        }
      end
    end
  end
end
