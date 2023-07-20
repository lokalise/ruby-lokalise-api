# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::QueuedProcesses do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:pagination_params) { { page: 2, limit: 1 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '2',
      'x-pagination-page-count': '2',
      'x-pagination-limit': '1',
      'x-pagination-page': '2'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "projects/#{project_id}/processes",
      req: { query: pagination_params },
      resp: {
        body: fixture('processes/processes_page2'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/processes",
      req: { query: pagination_params.merge(page: 1) },
      resp: {
        body: fixture('processes/processes_page1'),
        headers: pagination_headers.merge('x-pagination-page': 1)
      }
    )

    processes = test_client.queued_processes project_id, pagination_params

    expect(processes.collection.length).to eq(1)
    expect_to_have_valid_resources(processes)
    expect(processes.next_page?).to be false
    expect(processes.prev_page?).to be true

    prev_page_processes = processes.prev_page

    expect(prev_page_processes).to be_an_instance_of(described_class)
    expect(prev_page_processes[0].process_id).to eq('73ad976cedf00cd8a1b1b978ae3ffaade1323505')
    expect(prev_page_processes.next_page?).to be true
    expect(prev_page_processes.prev_page?).to be false
  end
end
