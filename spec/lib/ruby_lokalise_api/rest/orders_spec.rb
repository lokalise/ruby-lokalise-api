# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Orders do
  let(:team_id) { 176_692 }
  let(:order_id) { '201903198B2' }
  let(:project_id) { '803826145ba90b42d5d860.46800099' }

  specify '#orders' do
    stub(
      uri: "teams/#{team_id}/orders",
      resp: { body: fixture('orders/orders') }
    )

    orders = test_client.orders team_id

    expect(orders).to be_an_instance_of(RubyLokaliseApi::Collections::Orders)
    expect_to_have_valid_resources(orders)

    order = orders[0]

    expect(order.order_id).to eq('201903198B2')
  end

  specify '#order' do
    stub(
      uri: "teams/#{team_id}/orders/#{order_id}",
      resp: { body: fixture('orders/order') }
    )

    order = test_client.order team_id, order_id

    expect(order.team_id).to eq(team_id)
    expect(order.order_id).to eq(order_id)
    expect(order.project_id).to eq(project_id)
    expect(order.branch).to be_nil
    expect(order.card_id).to eq(1774)
    expect(order.status).to eq('completed')
    expect(order.created_at).to eq('2019-03-19 18:18:21 (Etc/UTC)')
    expect(order.created_at_timestamp).to eq(1_553_019_501)
    expect(order.created_by).to eq(20_181)
    expect(order.created_by_email).to eq('bodrovis@protonmail.com')
    expect(order.source_language_iso).to eq('en')
    expect(order.target_language_isos).to include('ru')
    expect(order.keys).to include(15_519_786)
    expect(order.source_words['ru']).to eq(1)
    expect(order.provider_slug).to eq('gengo')
    expect(order.translation_style).to eq('friendly')
    expect(order.translation_tier).to eq(1)
    expect(order.translation_tier_name).to eq('Professional translator')
    expect(order.briefing).to eq('Some briefing')
    expect(order.total).to eq(0.07)
    expect(order.payment_method).to be_nil
    expect(order.dry_run).to be_nil
  end

  specify '#create_order' do
    order_data = {
      project_id: '963054665b7c313dd9b323.35886655',
      card_id: 1774,
      briefing: 'demo',
      source_language_iso: 'en',
      target_language_isos: %w[ru],
      keys: [332_517_634, 62_341_144],
      provider_slug: 'gengo',
      translation_tier: 1,
      dry_run: true,
      translation_style: 'friendly'
    }

    stub(
      uri: "teams/#{team_id}/orders",
      req: { body: order_data, verb: :post },
      resp: { body: fixture('orders/create_order') }
    )

    order = test_client.create_order team_id, order_data

    expect(order.dry_run).to be true
    expect(order.team_id).to eq(team_id)
    expect(order.provider_slug).to eq('gengo')
  end
end
