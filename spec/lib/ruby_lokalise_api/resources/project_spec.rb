# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Project do
  let(:loaded_project_fixture) { loaded_fixture('projects/project') }

  let(:project_id) { loaded_project_fixture['project_id'] }

  let(:project_endpoint) do
    endpoint name: 'Projects', client: test_client, params: { query: [project_id] }
  end

  let(:project) do
    resource 'Project', response(loaded_project_fixture, project_endpoint)
  end

  let(:pagination_params) { { page: 1, limit: 2 } }

  specify '#update' do
    params = { name: 'OnBoarding-2023', description: 'Updated description' }

    stub(
      uri: "projects/#{project_id}",
      req: { body: params, verb: :put },
      resp: { body: fixture('projects/update_project') }
    )

    updated_project = project.update params

    expect(updated_project).to be_an_instance_of(described_class)
  end

  specify '#destroy' do
    created_project_fixture = loaded_fixture('projects/create_project')
    created_project_id = created_project_fixture['project_id']
    created_project_endpoint = endpoint(name: 'Projects', client: test_client, params: { query: [created_project_id] })
    created_project = resource 'Project', response(created_project_fixture, created_project_endpoint)

    stub(
      uri: "projects/#{created_project_id}",
      req: { verb: :delete },
      resp: { body: fixture('projects/destroy_project') }
    )

    resp = created_project.destroy
    expect(resp.project_id).to eq(created_project_id)
    expect(resp['project_id']).to eq(created_project_id)
    expect(resp.project_deleted).to be true
  end

  specify '#empty' do
    stub(
      uri: "projects/#{project_id}/empty",
      req: { verb: :put },
      resp: { body: fixture('projects/empty_project2') }
    )

    resp = project.empty

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::EmptiedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.keys_deleted).to be true
  end

  it 'allows to reload data and perform subsequent requests' do
    params = { name: 'OnBoarding-2023', description: 'Updated description' }

    stub(
      uri: "projects/#{project_id}",
      resp: { body: fixture('projects/project') }
    )

    stub(
      uri: "projects/#{project_id}",
      req: { body: params, verb: :put },
      resp: { body: fixture('projects/update_project') }
    )

    reloaded_project = project.reload_data

    updated_project = reloaded_project.update params

    expect(updated_project).to be_an_instance_of(described_class)

    key_id = 301_832_195
    comment_id = 16_588_650

    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments/#{comment_id}",
      resp: { body: fixture('comments/comment') }
    )

    reloaded_project = updated_project.reload_data

    expect(updated_project).to be_an_instance_of(described_class)

    comment = reloaded_project.key_comment(key_id, comment_id)

    expect(comment).to be_an_instance_of(RubyLokaliseApi::Resources::Comment)
  end

  context 'with branches' do
    let(:branch_id) { 1234 }

    it 'delegates branches' do
      expect_to_delegate(project, :branches, project_id, pagination_params) { |obj| obj.branches(pagination_params) }
    end

    it 'delegates branch' do
      expect_to_delegate(project, :branch, project_id, branch_id) { |obj| obj.branch(branch_id) }
    end

    it 'delegates create_branch' do
      params = {
        name: 'Ruby_SDK'
      }
      expect_to_delegate(project, :create_branch, project_id, params) { |obj| obj.create_branch(params) }
    end

    it 'delegates update_branch' do
      params = {
        name: 'Ruby_SDK'
      }
      expect_to_delegate(project, :update_branch, project_id, params) { |obj| obj.update_branch(params) }
    end

    it 'delegates destroy_branch' do
      expect_to_delegate(project, :destroy_branch, project_id, branch_id) { |obj| obj.destroy_branch(branch_id) }
    end

    it 'delegates merge_branch' do
      params = {
        force_conflict_resolve_using: 'source',
        target_branch_id: 5678
      }
      expect_to_delegate(project, :merge_branch, project_id, branch_id, params) do |obj|
        obj.merge_branch(branch_id, params)
      end
    end
  end

  context 'with comments' do
    let(:key_id) { 301_832_195 }
    let(:comment_id) { 16_588_650 }

    specify '#key_comment' do
      stub(
        uri: "projects/#{project_id}/keys/#{key_id}/comments/#{comment_id}",
        resp: { body: fixture('comments/comment') }
      )

      comment = project.key_comment(key_id, comment_id)

      expect(comment).to be_an_instance_of(RubyLokaliseApi::Resources::Comment)
    end

    it 'delegates key_comment to comment' do
      expect_to_delegate(project, :comment, project_id, key_id, comment_id) do |obj|
        obj.key_comment(key_id, comment_id)
      end
    end

    it 'delegates key_comments to comments' do
      expect_to_delegate(project, :comments, project_id, key_id, pagination_params) do |obj|
        obj.key_comments(key_id, pagination_params)
      end
    end

    it 'delegates project_comments' do
      expect_to_delegate(project, :project_comments, project_id, pagination_params) do |obj|
        obj.project_comments(pagination_params)
      end
    end

    it 'delegates create_comments' do
      params = [{ comment: 'Comment1' }, { comment: 'Comment2' }]

      expect_to_delegate(project, :create_comments, project_id, key_id, params) do |obj|
        obj.create_comments(key_id, params)
      end
    end

    specify '#create_comments' do
      comment_data = { comment: 'A single Ruby comment' }
      params = { comments: [comment_data] }

      stub(
        uri: "projects/#{project_id}/keys/#{key_id}/comments",
        req: { body: params, verb: :post },
        resp: { body: fixture('comments/single_created_comment') }
      )

      comments = project.create_comments key_id, comment_data

      expect(comments).to be_an_instance_of(RubyLokaliseApi::Collections::KeyComments)
      expect(comments.collection.length).to eq(1)
      expect_to_have_valid_resources(comments)

      comment = comments[0]

      expect(comment.project_id).to eq(project_id)
      expect(comment.comment).to eq(comment_data[:comment])
    end

    it 'delegates destroy_comment' do
      expect_to_delegate(project, :destroy_comment, project_id, key_id, comment_id) do |obj|
        obj.destroy_comment(key_id, comment_id)
      end
    end
  end

  context 'with contributors' do
    let(:contributor_id) { 123 }

    it 'delegates contributors' do
      expect_to_delegate(project, :contributors, project_id, pagination_params) do |obj|
        obj.contributors(pagination_params)
      end
    end

    it 'delegates contributor' do
      expect_to_delegate(project, :contributor, project_id, contributor_id) { |obj| obj.contributor(contributor_id) }
    end

    it 'delegates create_contributors' do
      params = {
        email: 'ruby@contributor.sample',
        fullname: 'Ruby Contributor',
        is_admin: true
      }

      expect_to_delegate(project, :create_contributors, project_id, params) { |obj| obj.create_contributors(params) }
    end

    it 'delegates update_contributor' do
      params = {
        is_reviewer: true
      }

      expect_to_delegate(project, :update_contributor, project_id, contributor_id, params) do |obj|
        obj.update_contributor(contributor_id, params)
      end
    end

    it 'delegates destroy_contributor' do
      expect_to_delegate(project, :destroy_contributor, project_id, contributor_id) do |obj|
        obj.destroy_contributor(contributor_id)
      end
    end
  end

  context 'with cts' do
    let(:status_id) { 567 }

    it 'delegates custom_translation_statuses' do
      expect_to_delegate(project, :custom_translation_statuses, project_id, pagination_params) do |obj|
        obj.custom_translation_statuses(pagination_params)
      end
    end

    it 'delegates custom_translation_status' do
      expect_to_delegate(project, :custom_translation_status, project_id, status_id) do |obj|
        obj.custom_translation_status(status_id)
      end
    end

    it 'delegates create_custom_translation_status' do
      params = {
        title: 'ruby',
        color: '#ff9f1a'
      }

      expect_to_delegate(project, :create_custom_translation_status, project_id, params) do |obj|
        obj.create_custom_translation_status(params)
      end
    end

    it 'delegates update_custom_translation_status' do
      params = {
        title: 'ruby'
      }

      expect_to_delegate(project, :update_custom_translation_status, project_id, status_id, params) do |obj|
        obj.update_custom_translation_status(status_id, params)
      end
    end

    it 'delegates destroy_custom_translation_status' do
      expect_to_delegate(project, :destroy_custom_translation_status, project_id, status_id) do |obj|
        obj.destroy_custom_translation_status(status_id)
      end
    end

    it 'delegates custom_translation_status_colors' do
      expect_to_delegate(project, :custom_translation_status_colors, project_id, &:custom_translation_status_colors)
    end
  end

  context 'with files' do
    it 'delegates files' do
      expect_to_delegate(project, :files, project_id, pagination_params) do |obj|
        obj.files(pagination_params)
      end
    end

    it 'delegates upload_file' do
      data = Base64.strict_encode64('{"key1": "Ruby", "key2": "RSpec"}')

      params = {
        data: data,
        filename: 'rspec.json',
        lang_iso: 'en'
      }

      expect_to_delegate(project, :upload_file, project_id, params) do |obj|
        obj.upload_file(params)
      end
    end

    it 'delegates download_files' do
      params = {
        format: :json,
        original_filenames: false
      }

      expect_to_delegate(project, :download_files, project_id, params) do |obj|
        obj.download_files(params)
      end
    end

    it 'delegates destroy_file' do
      file_id = 145
      expect_to_delegate(project, :destroy_file, project_id, file_id) do |obj|
        obj.destroy_file(file_id)
      end
    end
  end

  context 'with jwt' do
    it 'delegates create_jwt' do
      params = {
        service: :ota
      }

      expect_to_delegate(project, :create_jwt, project_id, params) do |obj|
        obj.create_jwt(params)
      end
    end
  end

  context 'with keys' do
    let(:key_id) { 876 }

    it 'delegates keys' do
      expect_to_delegate(project, :keys, project_id, pagination_params) do |obj|
        obj.keys(pagination_params)
      end
    end

    it 'delegates key' do
      expect_to_delegate(project, :key, project_id, key_id) do |obj|
        obj.key(key_id)
      end
    end

    it 'delegates create_keys' do
      params = [
        {
          key_name: 'ruby_k',
          platforms: %w[web ios],
          translations: [
            {
              language_iso: 'en',
              translation: 'Ruby key'
            }
          ]
        },
        {
          key_name: 'welcome',
          platforms: %w[web],
          filenames: {
            web: 'secondary-%LANG_ISO%.json'
          }
        }
      ]

      expect_to_delegate(project, :create_keys, project_id, params) do |obj|
        obj.create_keys(params)
      end
    end

    it 'delegates update_key' do
      params = { description: 'desc' }

      expect_to_delegate(project, :update_key, project_id, key_id, params) do |obj|
        obj.update_key(key_id, params)
      end
    end

    it 'delegates update_keys' do
      params = {
        use_automations: false,
        keys: [{
          key_id: 1
        }, {
          key_id: key_id,
          filenames: { web: '%LANG_ISO%.yml' }
        }]
      }

      expect_to_delegate(project, :update_keys, project_id, params) do |obj|
        obj.update_keys(params)
      end
    end

    it 'delegates destroy_key' do
      expect_to_delegate(project, :destroy_key, project_id, key_id) do |obj|
        obj.destroy_key(key_id)
      end
    end

    it 'delegates destroy_keys' do
      ids = [1, 2, 3]

      expect_to_delegate(project, :destroy_keys, project_id, ids) do |obj|
        obj.destroy_keys(ids)
      end
    end
  end

  context 'with languages' do
    let(:language_id) { 543 }

    it 'delegates languages to project_languages' do
      expect_to_delegate(project, :project_languages, project_id, pagination_params) do |obj|
        obj.languages(pagination_params)
      end
    end

    it 'delegates language to project_language' do
      expect_to_delegate(project, :project_language, project_id, language_id) do |obj|
        obj.language(language_id)
      end
    end

    it 'delegates create_languages to create_project_languages' do
      params = [{
        lang_iso: 'de'
      }, {
        lang_iso: 'nl'
      }]

      expect_to_delegate(project, :create_project_languages, project_id, params) do |obj|
        obj.create_languages(params)
      end
    end

    it 'delegates update_language to update_project_language' do
      params = {
        lang_name: 'French (updated)'
      }

      expect_to_delegate(project, :update_project_language, project_id, language_id, params) do |obj|
        obj.update_language(language_id, params)
      end
    end

    it 'delegates destroy_language to destroy_project_language' do
      expect_to_delegate(project, :destroy_project_language, project_id, language_id) do |obj|
        obj.destroy_language(language_id)
      end
    end
  end

  context 'with processes' do
    let(:process_id) { 156 }

    it 'delegates queued_processes' do
      expect_to_delegate(project, :queued_processes, project_id, pagination_params) do |obj|
        obj.queued_processes(pagination_params)
      end
    end

    it 'delegates queued_process' do
      expect_to_delegate(project, :queued_process, project_id, process_id) do |obj|
        obj.queued_process(process_id)
      end
    end
  end

  context 'with segments' do
    let(:key_id) { 353_507_573 }
    let(:lang_iso) { 'en' }
    let(:segment_number) { 1 }

    it 'delegates segments' do
      params = {
        disable_references: 1
      }
      expect_to_delegate(project, :segments, project_id, key_id, lang_iso, segment_number, params) do |obj|
        obj.segments(key_id, lang_iso, segment_number, params)
      end
    end

    it 'delegates segment' do
      params = { disable_references: 1 }

      expect_to_delegate(project, :segment, project_id, key_id, lang_iso, segment_number, params) do |obj|
        obj.segment(key_id, lang_iso, segment_number, params)
      end
    end

    it 'delegates update_segment' do
      params = {
        value: 'Updated.',
        is_fuzzy: false
      }

      expect_to_delegate(project, :update_segment, project_id, key_id, lang_iso, segment_number, params) do |obj|
        obj.update_segment(key_id, lang_iso, segment_number, params)
      end
    end
  end

  context 'with screenshots' do
    let(:screenshot_id) { 145 }

    it 'delegates screenshots' do
      expect_to_delegate(project, :screenshots, project_id, pagination_params) do |obj|
        obj.screenshots(pagination_params)
      end
    end

    it 'delegates screenshot' do
      expect_to_delegate(project, :screenshot, project_id, screenshot_id) do |obj|
        obj.screenshot(screenshot_id)
      end
    end

    it 'delegates create_screenshots' do
      params = [{
        data: 'fake',
        title: 'Ruby',
        description: 'SDK'
      }]

      expect_to_delegate(project, :create_screenshots, project_id, params) do |obj|
        obj.create_screenshots(params)
      end
    end

    it 'delegates update_screenshot' do
      params = {
        title: 'Ruby updated',
        tags: %w[one two]
      }

      expect_to_delegate(project, :update_screenshot, project_id, screenshot_id, params) do |obj|
        obj.update_screenshot(screenshot_id, params)
      end
    end

    it 'delegates destroy_screenshot' do
      expect_to_delegate(project, :destroy_screenshot, project_id, screenshot_id) do |obj|
        obj.destroy_screenshot(screenshot_id)
      end
    end
  end

  context 'with snapshots' do
    let(:snapshot_id) { 156 }

    it 'delegates snapshots' do
      expect_to_delegate(project, :snapshots, project_id, pagination_params) do |obj|
        obj.snapshots(pagination_params)
      end
    end

    it 'delegates create_snapshot' do
      params = {
        title: 'Ruby SDK'
      }

      expect_to_delegate(project, :create_snapshot, project_id, params) do |obj|
        obj.create_snapshot(params)
      end
    end

    it 'delegates restore_snapshot' do
      expect_to_delegate(project, :restore_snapshot, project_id, snapshot_id) do |obj|
        obj.restore_snapshot(snapshot_id)
      end
    end

    it 'delegates destroy_snapshot' do
      expect_to_delegate(project, :destroy_snapshot, project_id, snapshot_id) do |obj|
        obj.destroy_snapshot(snapshot_id)
      end
    end
  end

  context 'with tasks' do
    let(:task_id) { 145 }

    it 'delegates tasks' do
      expect_to_delegate(project, :tasks, project_id, pagination_params) do |obj|
        obj.tasks(pagination_params)
      end
    end

    it 'delegates task' do
      expect_to_delegate(project, :task, project_id, task_id) do |obj|
        obj.task(task_id)
      end
    end

    it 'delegates create_task' do
      params = {
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

      expect_to_delegate(project, :create_task, project_id, params) do |obj|
        obj.create_task(params)
      end
    end

    it 'delegates update_task' do
      params = {
        title: 'Ruby updated',
        description: 'updated via sdk'
      }

      expect_to_delegate(project, :update_task, project_id, task_id, params) do |obj|
        obj.update_task(task_id, params)
      end
    end

    it 'delegates destroy_task' do
      expect_to_delegate(project, :destroy_task, project_id, task_id) do |obj|
        obj.destroy_task(task_id)
      end
    end
  end

  context 'with translations' do
    let(:translation_id) { 156 }

    it 'delegates translations' do
      expect_to_delegate(project, :translations, project_id, pagination_params) do |obj|
        obj.translations(pagination_params)
      end
    end

    it 'delegates translation' do
      params = { disable_references: 1 }

      expect_to_delegate(project, :translation, project_id, translation_id, params) do |obj|
        obj.translation(translation_id, params)
      end
    end

    it 'delegates update_translation' do
      params = {
        translation: 'Updated from Ruby',
        is_reviewed: true
      }

      expect_to_delegate(project, :update_translation, project_id, translation_id, params) do |obj|
        obj.update_translation(translation_id, params)
      end
    end
  end

  context 'with webhooks' do
    let(:webhook_id) { 964 }

    it 'delegates webhooks' do
      expect_to_delegate(project, :webhooks, project_id, pagination_params) do |obj|
        obj.webhooks(pagination_params)
      end
    end

    it 'delegates webhook' do
      expect_to_delegate(project, :webhook, project_id, webhook_id) do |obj|
        obj.webhook(webhook_id)
      end
    end

    it 'delegates create_webhook' do
      params = {
        url: 'https://bodrovis.tech/lokalise',
        events: %w[project.snapshot project.branch.merged]
      }

      expect_to_delegate(project, :create_webhook, project_id, params) do |obj|
        obj.create_webhook(params)
      end
    end

    it 'delegates update_webhook' do
      params = {
        events: %w[project.exported]
      }

      expect_to_delegate(project, :update_webhook, project_id, params) do |obj|
        obj.update_webhook(params)
      end
    end

    it 'delegates regenerate_webhook_secret' do
      expect_to_delegate(project, :regenerate_webhook_secret, project_id, webhook_id) do |obj|
        obj.regenerate_webhook_secret(webhook_id)
      end
    end

    it 'delegates destroy_webhook' do
      expect_to_delegate(project, :destroy_webhook, project_id, webhook_id) do |obj|
        obj.destroy_webhook(webhook_id)
      end
    end
  end
end
