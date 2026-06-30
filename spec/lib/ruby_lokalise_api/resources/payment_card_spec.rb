# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::PaymentCard do
  let(:loaded_card_fixture) { loaded_fixture('payment_cards/payment_card') }

  let(:card_id) { loaded_card_fixture['payment_card']['card_id'] }

  let(:card_endpoint) do
    endpoint name: 'PaymentCards', client: test_client, params: { query: [card_id] }
  end

  let(:card) do
    resource 'PaymentCard', response(loaded_card_fixture, card_endpoint)
  end

  specify '#destroy' do
    stub(
      uri: "payment_cards/#{card_id}",
      req: { verb: :delete },
      resp: { body: fixture('payment_cards/destroy_payment_card') }
    )

    resp = card.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)

    expect(resp.card_id).to eq(card_id)
    expect(resp.card_deleted).to be true
  end

  it 'does not support update' do
    expect(card).not_to respond_to(:update)
  end

  specify '#reload_data' do
    stub(
      uri: "payment_cards/#{card_id}",
      resp: { body: fixture('payment_cards/payment_card') }
    )

    reloaded_card = card.reload_data

    expect(reloaded_card.card_id).to eq(card_id)
  end
end
