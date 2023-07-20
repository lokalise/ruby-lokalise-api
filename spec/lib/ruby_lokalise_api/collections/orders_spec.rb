# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Orders do
  let(:team_id) { 176_692 }

  let(:pagination_params) { { page: 3, limit: 2 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '10',
      'x-pagination-page-count': '5',
      'x-pagination-limit': '2',
      'x-pagination-page': '3'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "teams/#{team_id}/orders",
      req: { query: pagination_params },
      resp: {
        body: fixture('orders/orders_page3'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "teams/#{team_id}/orders",
      req: { query: pagination_params.merge(page: 2) },
      resp: {
        body: fixture('orders/orders_page2'),
        headers: pagination_headers.merge('x-pagination-page': 2)
      }
    )

    orders = test_client.orders team_id, pagination_params

    expect(orders.collection.length).to eq(2)
    expect_to_have_valid_resources(orders)
    expect(orders.next_page?).to be true
    expect(orders.prev_page?).to be true

    prev_page_orders = orders.prev_page

    expect(prev_page_orders).to be_an_instance_of(described_class)
    expect(prev_page_orders[0].order_id).to eq('20200116FM1')
    expect(prev_page_orders.next_page?).to be true
    expect(prev_page_orders.prev_page?).to be true

    next_page_orders = prev_page_orders.next_page

    expect(next_page_orders).to be_an_instance_of(described_class)
  end
end
