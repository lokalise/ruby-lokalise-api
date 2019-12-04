RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:key_id) { 15_571_976 }
  let(:task_id) { 4387 }

  describe '#tasks' do
    it 'returns all tasks' do
      tasks = VCR.use_cassette('all_tasks') do
        test_client.tasks project_id
      end.collection

      expect(tasks.count).to eq(3)
    end

    it 'supports pagination' do
      tasks = VCR.use_cassette('all_tasks_pagination') do
        test_client.tasks project_id, limit: 2, page: 2
      end

      expect(tasks.collection.count).to eq(1)
      expect(tasks.total_results).to eq(3)
      expect(tasks.total_pages).to eq(2)
      expect(tasks.results_per_page).to eq(2)
      expect(tasks.current_page).to eq(2)
    end
  end

  specify '#task' do
    task = VCR.use_cassette('task') do
      test_client.task project_id, '11925'
    end

    expect(task.task_id).to eq(11_925)
    expect(task.title).to eq('node updated')
    expect(task.description).to eq('')
    expect(task.status).to eq('in progress')
    expect(task.progress).to eq(1)
    expect(task.due_date).to eq(nil)
    expect(task.due_date_timestamp).to eq(nil)
    expect(task.keys_count).to eq(16)
    expect(task.words_count).to eq(275)
    expect(task.created_at).to eq('2019-05-13 16:15:26 (Etc/UTC)')
    expect(task.created_at_timestamp).to eq(1_557_764_126)
    expect(task.created_by).to eq(20_181)
    expect(task.created_by_email).to eq('bodrovis@protonmail.com')
    expect(task.can_be_parent).to eq(true)
    expect(task.task_type).to eq('review')
    expect(task.parent_task_id).to eq(nil)
    expect(task.closing_tags).to eq([])
    expect(task.languages.first['language_iso']).to eq('sq')
    expect(task.auto_close_languages).to eq(true)
    expect(task.auto_close_task).to eq(true)
    expect(task.completed_by).to eq(nil)
    expect(task.completed_by_email).to eq(nil)
    expect(task.completed_at).to eq(nil)
    expect(task.completed_at_timestamp).to eq(nil)
    expect(task.do_lock_translations).to eq(false)
    expect(task.custom_translation_status_ids).to eq([])
  end

  specify '#create_task' do
    task = VCR.use_cassette('create_task') do
      test_client.create_task project_id, title: 'another rspec key',
                                          keys: [key_id],
                                          languages: [
                                            {
                                              language_iso: 'ru',
                                              users: ['20181']
                                            }
                                          ]
    end

    expect(task.title).to eq('another rspec key')
    expect(task.languages.first['language_iso']).to eq('ru')
  end

  specify '#update_task' do
    task = VCR.use_cassette('update_task') do
      test_client.update_task project_id, task_id, description: 'desc here', auto_close_task: true
    end

    expect(task.task_id).to eq(task_id)
    expect(task.description).to eq('desc here')
    expect(task.auto_close_task).to eq(true)
  end

  specify '#destroy_task' do
    response = VCR.use_cassette('delete_task') do
      test_client.destroy_task project_id, task_id
    end
    expect(response['project_id']).to eq(project_id)
    expect(response['task_deleted']).to eq(true)
  end

  context 'task chained methods' do
    it 'supports update and destroy' do
      task = VCR.use_cassette('create_another_task') do
        test_client.create_task project_id, title: 'chained',
                                            keys: [key_id],
                                            languages: [
                                              {
                                                language_iso: 'ru',
                                                users: ['20181']
                                              }
                                            ]
      end

      expect(task.client).to eq(test_client)
      expect(task.title).to eq('chained')

      path = task.path

      updated_task = VCR.use_cassette('update_task_chained') do
        task.update title: 'updated!'
      end

      expect(updated_task.client).to eq(test_client)
      expect(updated_task.title).to eq('updated!')
      expect(updated_task.task_id).to eq(task.task_id)
      expect(updated_task.path).to eq(path)

      delete_response = VCR.use_cassette('delete_task_chained') do
        updated_task.destroy
      end

      expect(delete_response['project_id']).to eq(project_id)
      expect(delete_response['task_deleted']).to eq(true)
    end
  end
end
