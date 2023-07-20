# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module PaymentCards
      # Returns payment cards
      #
      # @see https://developers.lokalise.com/reference/list-all-cards
      # @return [RubyLokaliseApi::Collections::PaymentCards]
      # @param req_params [Hash]
      def payment_cards(req_params = {})
        name = 'PaymentCards'
        params = { req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single payment card
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-card
      # @return [RubyLokaliseApi::Resources::PaymentCard]
      # @param card_id [String, Integer]
      def payment_card(card_id)
        params = { query: card_id }

        data = endpoint(name: 'PaymentCards', params: params).do_get

        resource 'PaymentCard', data
      end

      # Creates a payment card
      #
      # @see https://developers.lokalise.com/reference/create-a-card
      # @return [RubyLokaliseApi::Resources::PaymentCard]
      # @param req_params [Hash]
      def create_payment_card(req_params)
        params = { req: req_params }

        data = endpoint(name: 'PaymentCards', params: params).do_post

        resource 'PaymentCard', data
      end

      # Deletes a payment card
      #
      # @see https://developers.lokalise.com/reference/delete-a-card
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param card_id [String, Integer]
      def destroy_payment_card(card_id)
        params = { query: card_id }

        data = endpoint(name: 'PaymentCards', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end
