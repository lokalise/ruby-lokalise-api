# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Keys do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:key_id) { 319_782_376 }
  let(:another_key_id) { 331_082_176 }
  let(:update_key_id) { 331_018_374 }

  describe '#key' do
    it 'requests a key' do
      stub(
        uri: "projects/#{project_id}/keys/#{key_id}",
        resp: { body: fixture('keys/key') }
      )

      key = test_client.key project_id, key_id

      expect(key).to be_an_instance_of(RubyLokaliseApi::Resources::Key)
      expect(key.branch).to eq('master')
      expect(key.project_id).to eq(project_id)
      expect(key.key_id).to eq(key_id)
      expect(key.created_at).to eq('2023-04-24 11:24:38 (Etc/UTC)')
      expect(key.created_at_timestamp).to eq(1_682_335_478)
      expect(key.key_name['ios']).to eq('login')
      expect(key.filenames['web']).to eq('main-%LANG_ISO%.json')
      expect(key.description).to eq('')
      expect(key.platforms).to include('ios')
      expect(key.tags).to eq([])
      expect(key.comments).to eq([])
      expect(key.screenshots).to eq([])
      expect(key.translations[0]['language_iso']).to eq('en')
      expect(key.is_plural).to be false
      expect(key.plural_name).to eq('')
      expect(key.is_hidden).to be false
      expect(key.is_archived).to be false
      expect(key.context).to eq('')
      expect(key.base_words).to eq(2)
      expect(key.char_limit).to eq(0)
      expect(key.custom_attributes).to eq('')
      expect(key.modified_at).to eq('2023-05-10 13:10:57 (Etc/UTC)')
      expect(key.modified_at_timestamp).to eq(1_683_724_257)
      expect(key.translations_modified_at).to eq('2023-05-18 12:55:16 (Etc/UTC)')
      expect(key.translations_modified_at_timestamp).to eq(1_684_414_516)
    end

    it 'requests a key with a GET query param' do
      stub(
        uri: "projects/#{project_id}/keys/#{key_id}?disable_references=1",
        resp: { body: fixture('keys/key') }
      )

      key = test_client.key project_id, key_id, disable_references: 1

      expect(key).to be_an_instance_of(RubyLokaliseApi::Resources::Key)
      expect(key.project_id).to eq(project_id)
      expect(key.key_id).to eq(key_id)
    end
  end

  specify '#keys' do
    stub(
      uri: "projects/#{project_id}/keys",
      resp: { body: fixture('keys/keys') }
    )

    keys = test_client.keys project_id
    expect(keys.collection.length).to eq(5)
    expect(keys).to be_an_instance_of(RubyLokaliseApi::Collections::Keys)
    expect_to_have_valid_resources(keys)
    expect(keys.project_id).to eq(project_id)
    expect(keys.branch).to eq('master')

    key = keys[0]

    expect(key.key_id).to eq(319_782_369)
    expect(key.project_id).to eq(project_id)
  end

  specify '#create_keys' do
    keys_data = [
      {
        key_name: 'ruby_k',
        platforms: %w[web ios],
        translations: [
          {
            language_iso: 'en',
            translation: 'Ruby key'
          }
        ]
      },
      {
        key_name: 'welcome',
        platforms: %w[web],
        filenames: {
          web: 'secondary-%LANG_ISO%.json'
        }
      }
    ]

    stub(
      uri: "projects/#{project_id}/keys",
      req: { body: { keys: keys_data }, verb: :post },
      resp: { body: fixture('keys/create_keys') }
    )

    keys = test_client.create_keys project_id, keys_data

    expect(keys).to be_an_instance_of(RubyLokaliseApi::Collections::Keys)
    expect_to_have_valid_resources(keys)

    expect(keys.project_id).to eq(project_id)
    expect(keys.branch).to eq('master')
    expect(keys.errors[0]['message']).to eq('This key name is already taken')

    key = keys[0]

    expect(key.project_id).to eq(project_id)
    expect(key.key_name['web']).to eq('ruby_k')
  end

  specify '#update_keys' do
    keys_data = {
      use_automations: false,
      keys: [{
        key_id: 1
      }, {
        key_id: update_key_id,
        filenames: { web: '%LANG_ISO%.yml' }
      }]
    }

    stub(
      uri: "projects/#{project_id}/keys",
      req: { body: keys_data, verb: :put },
      resp: { body: fixture('keys/update_keys') }
    )

    keys = test_client.update_keys project_id, keys_data

    error = keys.errors[0]

    expect(error['message']).to eq('Key not found in the project')
    expect(error['key_id']).to eq(1)

    key = keys[0]

    expect(key.key_id).to eq(update_key_id)
    expect(key.filenames['web']).to eq('%LANG_ISO%.yml')
  end

  specify '#update_key' do
    desc = 'Ruby updated'

    body = { description: desc }

    stub(
      uri: "projects/#{project_id}/keys/#{update_key_id}",
      req: { body: body, verb: :put },
      resp: { body: fixture('keys/update_key') }
    )

    key = test_client.update_key project_id, update_key_id, body

    expect(key.key_id).to eq(update_key_id)
    expect(key.project_id).to eq(project_id)
    expect(key.description).to eq(desc)
  end

  specify '#destroy_key' do
    stub(
      uri: "projects/#{project_id}/keys/#{another_key_id}",
      resp: { body: fixture('keys/key2') }
    )

    test_client.key project_id, another_key_id

    stub(
      uri: "projects/#{project_id}/keys/#{another_key_id}",
      req: { verb: :delete },
      resp: { body: fixture('keys/destroy_key') }
    )

    resp = test_client.destroy_key(project_id, another_key_id)

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)

    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.key_removed).to be true
    expect(resp.keys_locked).to eq(0)
  end

  specify '#destroy_keys' do
    key_ids = %w[331130927 331130924 331130922]

    stub(
      uri: "projects/#{project_id}/keys",
      req: { body: { keys: key_ids }, verb: :delete },
      resp: { body: fixture('keys/destroy_keys') }
    )

    resp = test_client.destroy_keys project_id, key_ids

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.keys_removed).to be true
    expect(resp.keys_locked).to eq(0)
  end
end
