RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:key_id) { 15_571_976 }
  let(:task_id) { 4387 }

  describe '#tasks' do
    it 'should return all tasks' do
      tasks = VCR.use_cassette('all_tasks') do
        test_client.tasks project_id
      end.collection

      expect(tasks.count).to eq(3)
    end

    it 'should support pagination' do
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
      test_client.task project_id, task_id
    end

    expect(task.task_id).to eq(task_id)
    expect(task.title).to eq('another rspec key')
    expect(task.description).to eq('desc here')
    expect(task.status).to eq('created')
    expect(task.progress).to eq(0)
    expect(task.due_date).to eq(nil)
    expect(task.keys_count).to eq(1)
    expect(task.words_count).to eq(0)
    expect(task.created_at).to eq('2018-12-10 18:37:02 (Etc/UTC)')
    expect(task.created_by).to eq(20_181)
    expect(task.created_by_email).to eq('bodrovis@protonmail.com')
    expect(task.can_be_parent).to eq(true)
    expect(task.task_type).to eq('translation')
    expect(task.parent_task_id).to eq(nil)
    expect(task.closing_tags).to eq([])
    expect(task.languages.first['language_iso']).to eq('ru')
    expect(task.auto_close_languages).to eq(true)
    expect(task.auto_close_task).to eq(true)
    expect(task.completed_by).to eq(nil)
    expect(task.completed_by_email).to eq(nil)
    expect(task.completed_at).to eq(nil)
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

  specify '#delete_task' do
    response = VCR.use_cassette('delete_task') do
      test_client.delete_task project_id, task_id
    end
    expect(response['project_id']).to eq(project_id)
    expect(response['task_deleted']).to eq(true)
  end
end
