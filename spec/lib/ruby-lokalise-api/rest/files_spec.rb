RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }

  describe '#files' do
    it 'should return all files' do
      files = VCR.use_cassette('files') do
        test_client.files project_id
      end.collection

      file = files.first

      expect(files.count).to eq(1)
      expect(file.filename).to eq('__unassigned__')
      expect(file.key_count).to eq(1)
    end

    it 'should support pagination' do
      files = VCR.use_cassette('all_files_pagination') do
        test_client.files project_id, limit: 1, page: 1
      end

      expect(files.collection.count).to eq(1)
      expect(files.total_results).to eq(1)
      expect(files.total_pages).to eq(1)
      expect(files.results_per_page).to eq(1)
      expect(files.current_page).to eq(1)

      expect(files.next_page).to be_nil
      expect(files.prev_page).to be_nil
    end
  end

  specify '#download_files' do
    response = VCR.use_cassette('download_files') do
      test_client.download_files project_id,
                                 "format": 'po',
                                 "original_filenames": true
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['bundle_url']).to include('amazonaws.com')
  end

  specify '#upload_file' do
    response = VCR.use_cassette('upload_file') do
      test_client.upload_file project_id,
                              "data": 'ZnI6DQogIHRlc3Q6IHRyYW5zbGF0aW9u',
                              "filename": 'rspec.yml',
                              'lang_iso': 'ru'
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['file']).to eq('rspec.yml')
    expect(response['result']['skipped']).to eq(1)
  end
end
