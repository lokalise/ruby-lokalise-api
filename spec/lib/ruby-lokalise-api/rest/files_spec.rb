# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }

  describe '#files' do
    it 'returns all files' do
      files = VCR.use_cassette('files') do
        test_client.files project_id
      end.collection

      file = files.first

      expect(files.count).to eq(1)
      expect(file.filename).to eq('__unassigned__')
      expect(file.key_count).to eq(1)
    end

    it 'supports pagination' do
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
                                 format: 'po',
                                 original_filenames: true
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['bundle_url']).to include('amazonaws.com')
  end

  specify '#upload_file' do
    process = VCR.use_cassette('upload_file') do
      test_client.upload_file project_id,
                              data: 'ZnI6DQogIHRlc3Q6IHRyYW5zbGF0aW9u',
                              filename: 'rspec_async.yml',
                              lang_iso: 'ru'
    end

    expect(process).to be_an_instance_of(Lokalise::Resources::QueuedProcess)
    expect(process.process_id).to eq('85c42bf5eff44648ca2f01f9db67b7d306a2f282')
    expect(process.status).to eq('queued')

    reloaded_process = VCR.use_cassette('upload_file_queued_reload') do
      process.reload_data
    end

    expect(reloaded_process.process_id).to eq(process.process_id)
    expect(reloaded_process.status).to eq('finished')
    expect(reloaded_process.details['files'][0]['status']).to eq('finished')
  end
end
