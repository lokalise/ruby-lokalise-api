# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:team_id) { 176_692 }
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:key_id) { 15_519_786 }
  let(:order_id) { '201903198B2' }
  let(:card_id) { 1774 }

  describe '#orders' do
    it 'returns all orders' do
      orders = VCR.use_cassette('all_orders') do
        test_client.orders team_id
      end.collection

      expect(orders.count).to eq(1)
      expect(orders.first.order_id).to eq(order_id)
    end

    it 'supports pagination' do
      orders = VCR.use_cassette('all_orders_pagination') do
        test_client.orders team_id, limit: 1, page: 1
      end

      expect(orders.collection.count).to eq(1)
      expect(orders.total_results).to eq(1)
      expect(orders.total_pages).to eq(1)
      expect(orders.results_per_page).to eq(1)
      expect(orders.current_page).to eq(1)
    end
  end

  specify '#order' do
    order = VCR.use_cassette('order') do
      test_client.order team_id, order_id
    end

    expect(order.order_id).to eq(order_id)
    expect(order.project_id).to eq(project_id)
    expect(order.card_id).to eq(card_id)
    expect(order.status).to eq('completed')
    expect(order.created_at).to eq('2019-03-19 18:18:21 (Etc/UTC)')
    expect(order.created_by).to eq(20_181)
    expect(order.created_by_email).to eq('bodrovis@protonmail.com')
    expect(order.source_language_iso).to eq('en')
    expect(order.target_language_isos).to eq(%w[ru])
    expect(order.keys).to eq([key_id])
    expect(order.source_words['ru']).to eq(1)
    expect(order.provider_slug).to eq('gengo')
    expect(order.translation_style).to eq('friendly')
    expect(order.translation_tier).to eq(1)
    expect(order.translation_tier_name).to eq('Professional translator')
    expect(order.briefing).to eq('Some briefing')
    expect(order.total).to eq(0.07)
    expect(order.payment_method).to be_nil
  end

  specify '#reload_data' do
    order = VCR.use_cassette('order') do
      test_client.order team_id, order_id
    end

    reloaded_order = VCR.use_cassette('order') do
      order.reload_data
    end

    expect(reloaded_order.order_id).to eq(order.order_id)
  end

  specify '#create_order' do
    order = VCR.use_cassette('create_order') do
      test_client.create_order team_id,
                               project_id: project_id,
                               card_id: card_id,
                               briefing: 'Some briefing',
                               source_language_iso: 'en',
                               target_language_isos: [
                                 'ru'
                               ],
                               keys: [
                                 key_id
                               ],
                               provider_slug: 'gengo',
                               translation_tier: '1'
    end

    expect(order.order_id).to eq(order_id)
    expect(order.status).to eq('in progress')
  end

  it 'creates an order with dry run' do
    order = VCR.use_cassette('create_order_dry_run') do
      test_client.create_order team_id,
                               project_id: project_id,
                               card_id: card_id,
                               briefing: 'Some briefing',
                               source_language_iso: 'en',
                               target_language_isos: [
                                 'ru'
                               ],
                               keys: [
                                 74_189_435
                               ],
                               provider_slug: 'gengo',
                               translation_tier: '1',
                               dry_run: true
    end

    expect(order.order_id).to be_nil
    expect(order.status).to eq('draft')
    expect(order.dry_run).to be true
  end
end
