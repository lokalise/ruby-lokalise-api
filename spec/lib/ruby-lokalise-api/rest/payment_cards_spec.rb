RSpec.describe Lokalise::Client do
  let(:card_id) { 1773 }

  describe '#payment_cards' do
    it 'returns all payment cards' do
      cards = VCR.use_cassette('all_payment_cards') do
        test_client.payment_cards
      end.collection

      card = cards.first
      expect(card.card_id).to eq(1774)
      expect(card.last4).to eq('0358')
    end

    it 'supports pagination' do
      cards = VCR.use_cassette('all_payment_cards_pagination') do
        test_client.payment_cards limit: 1, page: 1
      end

      expect(cards.collection.count).to eq(1)
      expect(cards.total_results).to eq(1)
      expect(cards.total_pages).to eq(1)
      expect(cards.results_per_page).to eq(1)
      expect(cards.current_page).to eq(1)

      expect(cards.next_page?).to eq(false)
      expect(cards.last_page?).to eq(true)
      expect(cards.prev_page?).to eq(false)
      expect(cards.first_page?).to eq(true)
    end
  end

  specify '#create_payment_card' do
    card = VCR.use_cassette('new_payment_card') do
      test_client.create_payment_card number: '4242424242424242',
                                      "cvc": '123',
                                      "exp_month": 1,
                                      "exp_year": 2030
    end

    expect(card.card_id).to eq(card_id)
    expect(card.last4).to eq('4242')
  end

  specify '#payment_card' do
    card = VCR.use_cassette('payment_card') do
      test_client.payment_card card_id
    end

    expect(card.card_id).to eq(card_id)
    expect(card.brand).to eq('Visa')
    expect(card.last4).to eq('4242')
    expect(card.created_at).to eq('2019-03-19 17:01:22 (Etc/UTC)')
  end

  specify '#destroy_payment_card' do
    result = VCR.use_cassette('destroy_payment_card') do
      test_client.destroy_payment_card card_id
    end

    expect(result['card_deleted']).to eq(true)
    expect(result['card_id']).to eq(card_id)
  end

  it 'supports chained destroy' do
    card = VCR.use_cassette('payment_card') do
      test_client.payment_card card_id
    end
    result = VCR.use_cassette('destroy_payment_card') do
      card.destroy
    end

    expect(result['card_deleted']).to eq(true)
    expect(result['card_id']).to eq(card_id)
  end
end
