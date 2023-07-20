# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Order do
  let(:team_id) { 176_692 }
  let(:order_id) { '201903198B2' }

  specify '#reload_data' do
    stub(
      uri: "teams/#{team_id}/orders/#{order_id}",
      resp: { body: fixture('orders/order') }
    )

    order = test_client.order team_id, order_id

    reloaded_order = order.reload_data

    expect(reloaded_order.order_id).to eq(order_id)
  end

  it 'does not support update' do
    stub(
      uri: "teams/#{team_id}/orders/#{order_id}",
      resp: { body: fixture('orders/order') }
    )

    order = test_client.order team_id, order_id

    expect(order).not_to respond_to(:update)
  end

  it 'does not support destroy' do
    stub(
      uri: "teams/#{team_id}/orders/#{order_id}",
      resp: { body: fixture('orders/order') }
    )

    order = test_client.order team_id, order_id

    expect(order).not_to respond_to(:destroy)
  end
end
