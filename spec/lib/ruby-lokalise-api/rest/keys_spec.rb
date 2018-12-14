RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:key_id) { 15_305_182 }
  let(:new_key_id) { 15_519_770 }

  describe '#keys' do
    it 'should return all keys' do
      keys = VCR.use_cassette('all_keys') do
        test_client.keys project_id
      end.collection

      expect(keys.count).to eq(1)
    end

    it 'should support pagination' do
      keys = VCR.use_cassette('all_keys_pagination') do
        test_client.keys project_id, limit: 1, page: 1
      end

      expect(keys.collection.count).to eq(1)
      expect(keys.total_results).to eq(1)
      expect(keys.total_pages).to eq(1)
      expect(keys.results_per_page).to eq(1)
      expect(keys.current_page).to eq(1)

      expect(keys.next_page?).to eq(false)
      expect(keys.last_page?).to eq(true)
      expect(keys.prev_page?).to eq(false)
      expect(keys.first_page?).to eq(true)
    end
  end

  specify '#key' do
    key = VCR.use_cassette('key') do
      test_client.key project_id, key_id, disable_references: 0
    end

    expect(key.key_id).to eq(key_id)
    expect(key.created_at).to eq('2018-12-03 19:11:30 (Etc/UTC)')
    expect(key.key_name['ios']).to eq('test')
    expect(key.filenames['web']).to eq('rspec.yml')
    expect(key.description).to eq('')
    expect(key.platforms).to eq(%w[web])
    expect(key.tags).to eq([])
    expect(key.comments.first['comment']).to eq('demo comment')
    expect(key.comments[1]['comment_id']).to eq(800_632)
    expect(key.screenshots).to eq([])
    expect(key.translations.first['modified_by_email']).to eq('bodrovis@protonmail.com')
    expect(key.is_plural).to eq(false)
    expect(key.plural_name).to eq('')
    expect(key.is_hidden).to eq(false)
    expect(key.is_archived).to eq(false)
    expect(key.context).to eq('')
    expect(key.char_limit).to eq(0)
    expect(key.custom_attributes).to eq('')
    expect(key.base_words).to eq(1)
  end

  specify '#create_keys' do
    keys = VCR.use_cassette('create_keys') do
      test_client.create_keys project_id, key_name: 'rspec_k', platforms: %w[ios]
    end

    key = keys.collection.first

    expect(keys.project_id).to eq(project_id)
    expect(key.key_name['ios']).to eq('rspec_k')
    expect(key.platforms).to eq(%w[ios])
  end

  specify '#update_key' do
    key = VCR.use_cassette('update_key') do
      test_client.update_key project_id, new_key_id, key_name: 'updated_rspec_k', description: 'desc here'
    end

    expect(key.key_name['ios']).to eq('updated_rspec_k')
    expect(key.platforms).to eq(%w[ios])
    expect(key.description).to eq('desc here')
  end

  specify '#update_keys' do
    keys = VCR.use_cassette('update_keys') do
      test_client.update_keys project_id, [
        {
          key_id: new_key_id,
          description: 'bulk updated'
        },
        {
          key_id: key_id,
          tags: %w[bulk upd]
        }
      ]
    end

    # `update_keys` returns a collection but it should not be paginated
    expect(keys.next_page?).to eq(false)
    expect(keys.prev_page?).to eq(false)

    first_key = keys.collection.first
    second_key = keys.collection[1]

    expect(first_key.key_id).to eq(key_id)
    expect(first_key.key_name['ios']).to eq('test')
    expect(first_key.tags).to eq(%w[bulk upd])

    expect(second_key.key_id).to eq(new_key_id)
    expect(second_key.key_name['web']).to eq('updated_rspec_k')
    expect(second_key.description).to eq('bulk updated')
  end

  specify '#destroy_key' do
    response = VCR.use_cassette('delete_key') do
      test_client.destroy_key project_id, '15519771'
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['key_removed']).to eq(true)
  end

  specify '#destroy_keys' do
    response = VCR.use_cassette('delete_keys') do
      test_client.destroy_keys project_id, [new_key_id, key_id]
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['keys_removed']).to eq(true)
  end

  context 'key chained methods' do
    it 'should support update and destroy' do
      key = VCR.use_cassette('create_another_key') do
        test_client.create_keys project_id, key_name: 'chained_k', platforms: %w[ios]
      end.collection.first

      expect(key.key_name['ios']).to eq('chained_k')

      path = key.path

      updated_key = VCR.use_cassette('update_key_chained') do
        key.update key_name: 'updated!'
      end

      expect(updated_key.client).to eq(test_client)
      expect(updated_key.key_name['ios']).to eq('updated!')
      expect(updated_key.path).to eq(path)

      delete_response = VCR.use_cassette('delete_key_chained') do
        updated_key.destroy
      end

      expect(delete_response['project_id']).to eq(project_id)
      expect(delete_response['key_removed']).to eq(true)
    end
  end

  context 'keys collection chained methods' do
    it 'should support destroy_all' do
      keys = VCR.use_cassette('create_keys_collection') do
        test_client.create_keys project_id, [
          {
            key_name: 'key_collect1', platforms: %w[ios]
          },
          {
            key_name: 'key_collect2', platforms: %w[ios]
          }
        ]
      end

      expect(keys.collection.length).to eq(2)

      delete_response = VCR.use_cassette('delete_all_keys_chained') do
        keys.destroy_all
      end

      expect(delete_response['project_id']).to eq(project_id)
      expect(delete_response['keys_removed']).to eq(true)
    end
  end
end
