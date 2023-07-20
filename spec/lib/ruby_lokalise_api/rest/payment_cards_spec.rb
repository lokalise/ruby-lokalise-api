# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::PaymentCards do
  let(:user_id) { 20_181 }
  let(:card_id) { 1774 }

  specify '#payment_cards' do
    stub(
      uri: 'payment_cards',
      resp: { body: fixture('payment_cards/payment_cards') }
    )

    cards = test_client.payment_cards

    expect(cards.collection.length).to eq(4)
    expect(cards).to be_an_instance_of(RubyLokaliseApi::Collections::PaymentCards)
    expect_to_have_valid_resources(cards)
    expect(cards.user_id).to eq(user_id)

    card = cards[0]

    expect(card.card_id).to eq(card_id)
    expect(card.user_id).to eq(user_id)
  end

  specify '#payment_card' do
    stub(
      uri: "payment_cards/#{card_id}",
      resp: { body: fixture('payment_cards/payment_card') }
    )

    card = test_client.payment_card card_id

    expect(card.card_id).to eq(card_id)
    expect(card.user_id).to eq(user_id)
    expect(card.last4).to eq('0358')
    expect(card.brand).to eq('Visa')
    expect(card.created_at).to eq('2019-03-19 17:49:07 (Etc/UTC)')
    expect(card.created_at_timestamp).to eq(1_553_017_747)
  end

  specify '#create_payment_card' do
    card_data = {
      number: '4242424242424242',
      cvc: '123',
      exp_month: '12',
      exp_year: '2020'
    }

    stub(
      uri: 'payment_cards',
      req: { body: card_data, verb: :post },
      resp: { body: fixture('payment_cards/create_payment_card') }
    )

    card = test_client.create_payment_card card_data

    expect(card.last4).to eq('4242')
  end

  specify '#destroy_payment_card' do
    stub(
      uri: "payment_cards/#{card_id}",
      req: { verb: :delete },
      resp: { body: fixture('payment_cards/destroy_payment_card') }
    )

    resp = test_client.destroy_payment_card(card_id)

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)

    expect(resp.card_id).to eq(card_id)
    expect(resp.card_deleted).to be true
  end
end
