# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:process_id) { '4191a4e54cb6433193e75eed55359c4021e6aa91' }
  let(:queued_process_id) { 'fb59937f47be1999b3643a7022d17bd46d807fad' }

  describe '#queued_processes' do
    it 'returns all queued processes' do
      processes = VCR.use_cassette('all_queued_processes') do
        test_client.queued_processes project_id
      end

      expect(processes.branch).to eq('master')
      processes = processes.collection
      expect(processes.count).to eq(2)
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
    expect(process.created_by).to eq('20181')
    expect(process.created_by_email).to eq('bodrovis@protonmail.com')
    expect(process.created_at).to eq('2020-05-11 11:17:52 (Etc/UTC)')
    expect(process.created_at_timestamp).to eq(1_589_195_872)
    expect(process.url).to eq('/api2/projects/803826145ba90b42d5d860.46800099/processes/file-import/4191a4e54cb6433193e75eed55359c4021e6aa91')
  end

  specify '#queued_process with process type' do
    process = VCR.use_cassette('queued_process_detailed2') do
      test_client.queued_process project_id, queued_process_id, 'file-import'
    end

    expect(process.process_id).to eq(queued_process_id)
    expect(process.type).to eq('file-import')
    expect(process.status).to eq('finished')
    expect(process.message).to eq('')
    expect(process.created_by).to eq('20181')
    expect(process.created_by_email).to eq('bodrovis@protonmail.com')
    expect(process.created_at).to eq('2020-05-14 10:18:03 (Etc/UTC)')
    expect(process.created_at_timestamp).to eq(1_589_451_483)
    expect(process.url).to eq('/api2/projects/803826145ba90b42d5d860.46800099/processes/file-import/fb59937f47be1999b3643a7022d17bd46d807fad')
    expect(process.files.count).to eq(1)
    file = process.files.first
    expect(file['status']).to eq('finished')
    expect(file['name_original']).to eq('rspec_async.yml')
    expect(file['word_count_total']).to eq(1)
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

    specify '#reload_data with detailed' do
      process = VCR.use_cassette('queued_process_detailed3') do
        test_client.queued_process project_id, queued_process_id, 'file-import'
      end

      reloaded_process = VCR.use_cassette('queued_process_detailed3') do
        process.reload_data
      end

      expect(reloaded_process.process_id).to eq(process.process_id)
    end
  end
end
