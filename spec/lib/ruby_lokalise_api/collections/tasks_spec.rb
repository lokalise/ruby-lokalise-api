# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Tasks do
  let(:project_id) { '88628569645b945648b474.25982965' }

  let(:pagination_params) { { page: 2, limit: 2 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '3',
      'x-pagination-page-count': '2',
      'x-pagination-limit': '2',
      'x-pagination-page': '2'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "projects/#{project_id}/tasks",
      req: { query: pagination_params },
      resp: {
        body: fixture('tasks/tasks_page2'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/tasks",
      req: { query: pagination_params.merge(page: 1) },
      resp: {
        body: fixture('tasks/tasks_page1'),
        headers: pagination_headers.merge('x-pagination-page': 1)
      }
    )

    tasks = test_client.tasks project_id, pagination_params

    expect(tasks.collection.length).to eq(1)
    expect_to_have_valid_resources(tasks)
    expect(tasks.next_page?).to be false
    expect(tasks.prev_page?).to be true

    prev_page_tasks = tasks.prev_page

    expect(prev_page_tasks).to be_an_instance_of(described_class)
    expect(prev_page_tasks[0].task_id).to eq(1_721_560)
    expect(prev_page_tasks.next_page?).to be true
    expect(prev_page_tasks.prev_page?).to be false

    next_page_tasks = prev_page_tasks.next_page

    expect(next_page_tasks).to be_an_instance_of(described_class)
  end
end
