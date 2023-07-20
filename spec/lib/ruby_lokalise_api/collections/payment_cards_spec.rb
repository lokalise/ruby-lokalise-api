# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::PaymentCards do
  let(:pagination_params) { { page: 2, limit: 1 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '4',
      'x-pagination-page-count': '4',
      'x-pagination-limit': '1',
      'x-pagination-page': '2'
    }
  end

  it 'supports pagination' do
    stub(
      uri: 'payment_cards',
      req: { query: pagination_params },
      resp: {
        body: fixture('payment_cards/payment_cards_page2'),
        headers: pagination_headers
      }
    )

    stub(
      uri: 'payment_cards',
      req: { query: pagination_params.merge(page: 3) },
      resp: {
        body: fixture('payment_cards/payment_cards_page3'),
        headers: pagination_headers.merge('x-pagination-page': 3)
      }
    )

    cards = test_client.payment_cards pagination_params

    expect(cards.collection.length).to eq(1)
    expect_to_have_valid_resources(cards)
    expect(cards.next_page?).to be true
    expect(cards.prev_page?).to be true

    next_page_cards = cards.next_page

    expect(next_page_cards).to be_an_instance_of(described_class)
    expect(next_page_cards[0].card_id).to eq(3574)
    expect(next_page_cards.next_page?).to be true
    expect(next_page_cards.prev_page?).to be true

    prev_page_cards = next_page_cards.prev_page

    expect(prev_page_cards).to be_an_instance_of(described_class)
  end
end
