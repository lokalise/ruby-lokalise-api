# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:process_id) { '3b943469e6b3e324b5bdad639b122a623e6e7a1a' }
  let(:queued_process_id) { 'ff1876382b7ba81f2bb465da8f030196ec401fa6' }

  describe '#queued_processes' do
    it 'returns all queued processes' do
      processes = VCR.use_cassette('all_queued_processes') do
        test_client.queued_processes project_id
      end

      expect(processes.branch).to eq('master')
      processes = processes.collection
      puts processes.count
      expect(processes.count).to eq(8)
      expect(processes.first.process_id).to eq(process_id)
    end
  end

  specify '#queued_process' do
    process = VCR.use_cassette('queued_process') do
      test_client.queued_process project_id, process_id
    end

    expect(process.branch).to eq('master')
    expect(process.process_id).to eq(process_id)
    expect(process.type).to eq('file-import')
    expect(process.status).to eq('finished')
    expect(process.message).to eq('')
    expect(process.created_by).to eq(20_181)
    expect(process.created_by_email).to eq('bodrovis@protonmail.com')
    expect(process.created_at).to eq('2020-05-13 11:24:37 (Etc/UTC)')
    expect(process.created_at_timestamp).to eq(1_589_369_077)
    files = process.details['files']
    expect(files.count).to eq(1)
    expect(files[0]['status']).to eq('finished')
    expect(files[0]['name_original']).to eq('test_async.json')
  end

  describe 'process status check' do
    specify '#reload_data' do
      queued_process = VCR.use_cassette('upload_file_status') do
        test_client.queued_process project_id, queued_process_id
      end

      expect(queued_process.status).to eq('queued')

      reloaded_process = VCR.use_cassette('upload_file_queued_reload') do
        queued_process.reload_data
      end

      expect(reloaded_process.process_id).to eq(queued_process.process_id)
      expect(reloaded_process.status).to eq('finished')
    end
  end
end
