# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::TranslationProvider do
  let(:team_id) { 176_692 }
  let(:provider_id) { 1 }

  specify '#reload_data' do
    stub(
      uri: "teams/#{team_id}/translation_providers/#{provider_id}",
      resp: { body: fixture('translation_providers/translation_provider') }
    )

    provider = test_client.translation_provider team_id, provider_id

    reloaded_provider = provider.reload_data

    expect(reloaded_provider.provider_id).to eq(provider_id)
  end

  it 'does not support update' do
    stub(
      uri: "teams/#{team_id}/translation_providers/#{provider_id}",
      resp: { body: fixture('translation_providers/translation_provider') }
    )

    provider = test_client.translation_provider team_id, provider_id

    expect(provider).not_to respond_to(:update)
  end

  it 'does not support destroy' do
    stub(
      uri: "teams/#{team_id}/translation_providers/#{provider_id}",
      resp: { body: fixture('translation_providers/translation_provider') }
    )

    provider = test_client.translation_provider team_id, provider_id

    expect(provider).not_to respond_to(:destroy)
  end
end
