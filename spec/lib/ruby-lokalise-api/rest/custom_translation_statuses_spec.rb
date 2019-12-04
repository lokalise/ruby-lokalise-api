RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:status_id) { 128 }
  let(:new_status_id) { 126 }

  describe '#translation_statuses' do
    it 'returns all statuses' do
      statuses = VCR.use_cassette('all_translation_statuses') do
        test_client.translation_statuses project_id
      end.collection

      expect(statuses.count).to eq(3)
      expect(statuses.first.status_id).to eq(status_id)
    end

    it 'supports pagination' do
      statuses = VCR.use_cassette('all_translation_statuses_pagination') do
        test_client.translation_statuses project_id, limit: 1, page: 2
      end

      expect(statuses.collection.count).to eq(1)
      expect(statuses.total_results).to eq(3)
      expect(statuses.total_pages).to eq(3)
      expect(statuses.results_per_page).to eq(1)
      expect(statuses.current_page).to eq(2)

      expect(statuses.next_page?).to eq(true)
      expect(statuses.last_page?).to eq(false)
      expect(statuses.prev_page?).to eq(true)
      expect(statuses.first_page?).to eq(false)
    end
  end

  specify '#translation_status' do
    status = VCR.use_cassette('translation_status') do
      test_client.translation_status project_id, status_id
    end

    expect(status.status_id).to eq(status_id)
    expect(status.title).to eq('random')
    expect(status.color).to eq('#0079bf')
  end

  specify '#create_translation_status' do
    title = 'Reviewed by doctors'
    color = '#f2d600'
    status = VCR.use_cassette('create_translation_status') do
      test_client.create_translation_status project_id,
                                            title: title,
                                            color: color
    end

    expect(status.title).to eq(title)
    expect(status.color).to eq(color)
  end

  specify '#update_translation_status' do
    title = 'Reviewed by rubyists'
    color = '#c377e0'
    status = VCR.use_cassette('update_translation_status') do
      test_client.update_translation_status project_id, new_status_id,
                                            title: title,
                                            color: color
    end

    expect(status.title).to eq(title)
    expect(status.color).to eq(color)
  end

  specify '#destroy_translation_status' do
    response = VCR.use_cassette('destroy_translation_status') do
      test_client.destroy_translation_status project_id, new_status_id
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['custom_translation_status_deleted']).to eq(true)
  end

  specify '#translation_status_colors' do
    response = VCR.use_cassette('translation_status_colors') do
      test_client.translation_status_colors project_id
    end

    expect(response).to be_an(Array)
    expect(response).to include('#f2d600')
  end

  context 'translation status chained methods' do
    it 'supports update and destroy' do
      status = VCR.use_cassette('create_another_translation_status') do
        test_client.create_translation_status project_id,
                                              title: 'rspec',
                                              color: '#c377e0'
      end

      expect(status.title).to eq('rspec')
      expect(status.color).to eq('#c377e0')

      status = VCR.use_cassette('update_another_translation_status') do
        status.update(
          title: 'updated rspec',
          color: '#0079bf'
        )
      end

      expect(status.title).to eq('updated rspec')
      expect(status.color).to eq('#0079bf')

      response = VCR.use_cassette('delete_another_translation_status') do
        status.destroy
      end

      expect(response['project_id']).to eq(project_id)
      expect(response['custom_translation_status_deleted']).to eq(true)
    end
  end
end
