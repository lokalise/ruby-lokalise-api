# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::TranslationProviders do
  let(:team_id) { 176_692 }
  let(:provider_id) { 1 }

  specify '#translation_providers' do
    stub(
      uri: "teams/#{team_id}/translation_providers",
      resp: { body: fixture('translation_providers/translation_providers') }
    )

    providers = test_client.translation_providers team_id

    expect(providers.collection.length).to eq(4)
    expect_to_have_valid_resources(providers)
    expect(providers[0].provider_id).to eq(1)
  end

  specify '#translation_provider' do
    stub(
      uri: "teams/#{team_id}/translation_providers/#{provider_id}",
      resp: { body: fixture('translation_providers/translation_provider') }
    )

    provider = test_client.translation_provider team_id, provider_id

    expect(provider.team_id).to eq(team_id)
    expect(provider.provider_id).to eq(provider_id)
    expect(provider.name).to eq('Gengo')
    expect(provider.slug).to eq('gengo')
    expect(provider.price_pair_min).to eq('0.00')
    expect(provider.website_url).to eq('https://gengo.com')
    expect(provider.description).to include('At Gengo,')
    expect(provider.tiers[0]['tier_id']).to eq(1)
    expect(provider.pairs[0]['price_per_word']).to eq(0.069)
  end
end
