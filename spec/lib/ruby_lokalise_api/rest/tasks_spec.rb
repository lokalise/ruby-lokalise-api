# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Tasks do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:task_id) { 1_721_560 }
  let(:another_task_id) { 1_721_633 }

  specify '#tasks' do
    stub(
      uri: "projects/#{project_id}/tasks",
      resp: { body: fixture('tasks/tasks') }
    )

    tasks = test_client.tasks project_id

    expect(tasks.collection.length).to eq(3)
    expect_to_have_valid_resources(tasks)
    expect(tasks.project_id).to eq(project_id)
    expect(tasks.branch).to eq('master')

    task = tasks[0]

    expect(task.task_id).to eq(task_id)
  end

  specify '#task' do
    stub(
      uri: "projects/#{project_id}/tasks/#{task_id}",
      resp: { body: fixture('tasks/task') }
    )

    task = test_client.task project_id, task_id

    expect(task.project_id).to eq(project_id)
    expect(task.branch).to eq('master')
    expect(task.task_id).to eq(task_id)
    expect(task.title).to eq('Demo2')
    expect(task.can_be_parent).to be true
    expect(task.parent_task_id).to be_nil
    expect(task.closing_tags).to eq([])
    expect(task.description).to eq('')
    expect(task.status).to eq('created')
    expect(task.progress).to eq(0)
    expect(task.due_date).to be_nil
    expect(task.due_date_timestamp).to be_nil
    expect(task.keys_count).to eq(7)
    expect(task.words_count).to eq(19)
    expect(task.created_at).to eq('2023-07-14 11:59:04 (Etc/UTC)')
    expect(task.created_at_timestamp).to eq(1_689_335_944)
    expect(task.created_by).to eq(20_181)
    expect(task.created_by_email).to eq('bodrovis@protonmail.com')
    expect(task.source_language_iso).to eq('en')
    expect(task.languages[0]['language_iso']).to eq('de')
    expect(task.auto_close_items).to be true
    expect(task.auto_close_languages).to be true
    expect(task.auto_close_task).to be true
    expect(task.completed_at).to be_nil
    expect(task.completed_at_timestamp).to be_nil
    expect(task.completed_by).to be_nil
    expect(task.completed_by_email).to be_nil
    expect(task.do_lock_translations).to be true
    expect(task.custom_translation_status_ids).to eq([])
  end

  specify '#create_task' do
    task_data = {
      title: 'Ruby SDK',
      keys: %w[331018374 324729217],
      languages: [
        {
          language_iso: 'de',
          users: %w[20181]
        }
      ],
      source_language_iso: 'en',
      task_type: 'translation'
    }

    stub(
      uri: "projects/#{project_id}/tasks",
      req: { body: task_data, verb: :post },
      resp: { body: fixture('tasks/create_task') }
    )

    task = test_client.create_task project_id, task_data

    expect(task.project_id).to eq(project_id)
    expect(task.title).to eq(task_data[:title])
    expect(task.status).to eq('created')
  end

  specify '#update_task' do
    task_data = {
      title: 'Ruby updated',
      description: 'updated via sdk'
    }

    stub(
      uri: "projects/#{project_id}/tasks/#{another_task_id}",
      req: { body: task_data, verb: :put },
      resp: { body: fixture('tasks/update_task') }
    )

    task = test_client.update_task project_id, another_task_id, task_data

    expect(task).to be_an_instance_of(RubyLokaliseApi::Resources::Task)
    expect(task.title).to eq(task_data[:title])
    expect(task.description).to eq(task_data[:description])
  end

  specify '#destroy_task' do
    stub(
      uri: "projects/#{project_id}/tasks/#{another_task_id}",
      req: { verb: :delete },
      resp: { body: fixture('tasks/destroy_task') }
    )

    resp = test_client.destroy_task project_id, another_task_id

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.task_deleted).to be true
  end
end
