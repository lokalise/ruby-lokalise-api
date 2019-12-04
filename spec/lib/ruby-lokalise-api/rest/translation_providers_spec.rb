RSpec.describe Lokalise::Client do
  let(:team_id) { 176_692 }

  describe '#translation_providers' do
    it 'returns all providers' do
      providers = VCR.use_cassette('all_translation_providers') do
        test_client.translation_providers team_id
      end.collection

      expect(providers.count).to eq(2)
      expect(providers.first.slug).to eq('gengo')
    end

    it 'supports pagination' do
      providers = VCR.use_cassette('all_translation_providers_pagination') do
        test_client.translation_providers team_id, limit: 1, page: 2
      end

      expect(providers.collection.count).to eq(1)
      expect(providers.total_results).to eq(2)
      expect(providers.total_pages).to eq(2)
      expect(providers.results_per_page).to eq(1)
      expect(providers.current_page).to eq(2)
    end
  end

  specify '#translation_provider' do
    provider = VCR.use_cassette('translation_provider') do
      test_client.translation_provider team_id, 1
    end

    expect(provider.provider_id).to eq(1)
    expect(provider.name).to eq('Gengo')
    expect(provider.slug).to eq('gengo')
    expect(provider.price_pair_min).to eq('0.00')
    expect(provider.website_url).to eq('https://gengo.com')
    expect(provider.description.start_with?('At')).to eq(true)
    expect(provider.tiers.first['title']).to eq('Native speaker')
    expect(provider.pairs.first['price_per_word']).to eq('0.05')
  end
end
