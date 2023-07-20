# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Task do
  let(:project_id) { '88628569645b945648b474.25982965' }

  let(:loaded_task_fixture) { loaded_fixture('tasks/task') }

  let(:task_id) { loaded_task_fixture['task']['task_id'] }

  let(:task_endpoint) do
    endpoint name: 'Tasks', client: test_client, params: { query: [project_id, task_id] }
  end

  let(:task) do
    resource 'Task', response(loaded_task_fixture, task_endpoint)
  end

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/tasks/#{task_id}",
      resp: { body: fixture('tasks/task') }
    )

    reloaded_task = task.reload_data

    expect(reloaded_task.task_id).to eq(task_id)
  end

  specify '#update' do
    task_data = {
      title: 'Ruby updated',
      description: 'updated via sdk'
    }

    stub(
      uri: "projects/#{project_id}/tasks/#{task_id}",
      req: { body: task_data, verb: :put },
      resp: { body: fixture('tasks/update_task2') }
    )

    updated_task = task.update task_data

    expect(updated_task).to be_an_instance_of(described_class)
    expect(updated_task.title).to eq(task_data[:title])
    expect(updated_task.description).to eq(task_data[:description])
  end

  specify '#destroy' do
    stub(
      uri: "projects/#{project_id}/tasks/#{task_id}",
      req: { verb: :delete },
      resp: { body: fixture('tasks/destroy_task') }
    )

    resp = task.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.task_deleted).to be true
  end
end
