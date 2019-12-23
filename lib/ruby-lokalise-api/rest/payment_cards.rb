# frozen_string_literal: true

module Lokalise
  class Client
    # Returns all payment cards available to the user authorized with the API token
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-cards-get
    # @return [Lokalise::Collection::PaymentCard<Lokalise::Resources::PaymentCard>]
    # @param params [Hash]
    def payment_cards(params = {})
      c_r Lokalise::Collections::PaymentCard, :all, nil, params
    end

    # Returns a single payment card
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-card-get
    # @return [Lokalise::Resources::PaymentCard]
    # @param card_id [String, Integer]
    def payment_card(card_id)
      c_r Lokalise::Resources::PaymentCard, :find, card_id
    end

    # Creates a payment card
    #
    # @see https://lokalise.co/api2docs/curl/#transition-create-a-card-post
    # @return [Lokalise::Resources::PaymentCard]
    # @param params [Hash]
    def create_payment_card(params)
      c_r Lokalise::Resources::PaymentCard, :create, nil, params
    end

    # Deletes the payment card
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-card-delete
    # @return [Hash]
    # @param card_id [String, Integer]
    def destroy_payment_card(card_id)
      c_r Lokalise::Resources::PaymentCard, :destroy, card_id
    end
  end
end
