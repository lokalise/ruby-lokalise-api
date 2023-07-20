# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Translation do
  let(:project_id) { '88628569645b945648b474.25982965' }

  let(:loaded_translation_fixture) { loaded_fixture('translations/translation') }

  let(:translation_id) { loaded_translation_fixture['translation']['translation_id'] }

  let(:translation_endpoint) do
    endpoint name: 'Translations', client: test_client, params: { query: [project_id, translation_id] }
  end

  let(:translation) do
    resource 'Translation', response(loaded_translation_fixture, translation_endpoint)
  end

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/translations/#{translation_id}",
      resp: { body: fixture('translations/translation') }
    )

    reloaded_translation = translation.reload_data

    expect(reloaded_translation.translation_id).to eq(translation_id)
  end

  specify '#update' do
    translation_data = {
      translation: 'Updated from Ruby',
      is_reviewed: true
    }

    stub(
      uri: "projects/#{project_id}/translations/#{translation_id}",
      req: { body: translation_data, verb: :put },
      resp: { body: fixture('translations/update_translation') }
    )

    updated_translation = translation.update translation_data

    expect(updated_translation).to be_an_instance_of(described_class)
    expect(updated_translation.translation).to eq(translation_data[:translation])
    expect(updated_translation.is_reviewed).to eq(translation_data[:is_reviewed])
  end

  it 'does not support destroy' do
    expect(translation).not_to respond_to(:destroy)
  end
end
