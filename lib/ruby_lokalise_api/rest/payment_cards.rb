# frozen_string_literal: true

module RubyLokaliseApi
  class Client
    # Returns all payment cards available to the user authorized with the API token
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-list-all-cards-get
    # @return [RubyLokaliseApi::Collection::PaymentCard<RubyLokaliseApi::Resources::PaymentCard>]
    # @param params [Hash]
    def payment_cards(params = {})
      c_r RubyLokaliseApi::Collections::PaymentCard, :all, nil, params
    end

    # Returns a single payment card
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-retrieve-a-card-get
    # @return [RubyLokaliseApi::Resources::PaymentCard]
    # @param card_id [String, Integer]
    def payment_card(card_id)
      c_r RubyLokaliseApi::Resources::PaymentCard, :find, card_id
    end

    # Creates a payment card
    #
    # @see https://lokalise.co/api2docs/curl/#transition-create-a-card-post
    # @return [RubyLokaliseApi::Resources::PaymentCard]
    # @param params [Hash]
    def create_payment_card(params)
      c_r RubyLokaliseApi::Resources::PaymentCard, :create, nil, params
    end

    # Deletes the payment card
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-delete-a-card-delete
    # @return [Hash]
    # @param card_id [String, Integer]
    def destroy_payment_card(card_id)
      c_r RubyLokaliseApi::Resources::PaymentCard, :destroy, card_id
    end
  end
end
