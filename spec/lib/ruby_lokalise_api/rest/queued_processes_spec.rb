# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::QueuedProcesses do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:process_id) { '73ad976cedf00cd8a1b1b978ae3ffaade1323505' }

  specify '#queued_process' do
    stub(
      uri: "projects/#{project_id}/processes/#{process_id}",
      resp: { body: fixture('processes/process') }
    )

    process = test_client.queued_process project_id, process_id

    expect(process.project_id).to eq(project_id)
    expect(process.branch).to eq('master')
    expect(process.process_id).to eq(process_id)
    expect(process.type).to eq('file-import')
    expect(process.status).to eq('finished')
    expect(process.message).to eq('')
    expect(process.created_by).to eq(20_181)
    expect(process.created_by_email).to eq('bodrovis@protonmail.com')
    expect(process.created_at).to eq('2023-05-12 10:59:43 (Etc/UTC)')
    expect(process.created_at_timestamp).to eq(1_683_889_183)
    expect(process.details['files'][0]['name_original']).to eq('pasted.json')
  end

  specify '#queued_processes' do
    stub(
      uri: "projects/#{project_id}/processes",
      resp: { body: fixture('processes/processes') }
    )

    processes = test_client.queued_processes project_id

    expect(processes.collection.length).to eq(2)
    expect_to_have_valid_resources(processes)
    expect(processes.project_id).to eq(project_id)
    expect(processes.branch).to eq('master')

    process = processes[0]

    expect(process.process_id).to eq(process_id)
    expect(process.project_id).to eq(project_id)
  end
end
