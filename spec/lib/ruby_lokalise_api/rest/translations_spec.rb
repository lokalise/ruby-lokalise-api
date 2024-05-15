# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Translations do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:translation_id) { 2_574_122_388 }

  describe '#translations' do
    it 'fetches all translations' do
      stub(
        uri: "projects/#{project_id}/translations",
        resp: { body: fixture('translations/translations') }
      )

      translations = test_client.translations project_id

      expect(translations.collection.length).to eq(3)
      expect_to_have_valid_resources(translations)
      expect(translations.project_id).to eq(project_id)

      translation = translations[0]

      expect(translation.translation_id).to eq(translation_id)
    end

    it 'fetches translation with cursor' do
      cursor_params = {
        pagination: 'cursor',
        limit: 2,
        cursor: 'eyIxIjoyNjU4ODM0NDUyfQ=='
      }

      stub(
        uri: "projects/#{project_id}/translations",
        req: { query: cursor_params },
        resp: {
          body: fixture('translations/translations'),
          headers: {
            'x-pagination-limit': '2',
            'x-pagination-next-cursor': 'eyIxIjoyNjU4ODM0NDUzfQ=='
          }
        }
      )

      translations = test_client.translations project_id, cursor_params

      expect(translations.collection.length).to eq(3)
      expect_to_have_valid_resources(translations)
      expect(translations.project_id).to eq(project_id)

      expect(translations.next_cursor?).to be true
      expect(translations.next_cursor).to eq('eyIxIjoyNjU4ODM0NDUzfQ==')

      translation = translations[0]

      expect(translation.translation_id).to eq(translation_id)
    end
  end

  specify '#translation' do
    stub(
      uri: "projects/#{project_id}/translations/#{translation_id}?disable_references=1",
      resp: { body: fixture('translations/translation') }
    )

    translation = test_client.translation project_id, translation_id, disable_references: 1

    expect(translation.translation_id).to eq(translation_id)
    expect(translation.project_id).to eq(project_id)
    expect(translation.branch).to eq('master')
    expect(translation.segment_number).to eq(1)
    expect(translation.key_id).to eq(319_782_369)
    expect(translation.language_iso).to eq('en')
    expect(translation.translation).to include('Lokalise')
    expect(translation.modified_by).to eq(20_181)
    expect(translation.modified_by_email).to eq('bodrovis@protonmail.com')
    expect(translation.modified_at).to eq('2023-05-19 15:52:12 (Etc/UTC)')
    expect(translation.modified_at_timestamp).to eq(1_684_511_532)
    expect(translation.is_reviewed).to be false
    expect(translation.reviewed_by).to eq(0)
    expect(translation.is_unverified).to be false
    expect(translation.is_fuzzy).to be false
    expect(translation.words).to eq(3)
    expect(translation.custom_translation_statuses).to eq([])
    expect(translation.task_id).to be_nil
  end

  specify '#update_translation' do
    translation_data = {
      translation: 'Updated from Ruby',
      is_reviewed: true
    }

    stub(
      uri: "projects/#{project_id}/translations/#{translation_id}",
      req: { body: translation_data, verb: :put },
      resp: { body: fixture('translations/update_translation') }
    )

    translation = test_client.update_translation project_id, translation_id, translation_data

    expect(translation).to be_an_instance_of(RubyLokaliseApi::Resources::Translation)
    expect(translation.translation).to eq(translation_data[:translation])
    expect(translation.is_reviewed).to eq(translation_data[:is_reviewed])
  end
end
