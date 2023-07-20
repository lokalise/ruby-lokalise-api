# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class PaymentCards < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::PaymentCardsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::PaymentCard
    end
  end
end
