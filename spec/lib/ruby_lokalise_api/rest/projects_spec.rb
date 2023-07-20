# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Projects do
  let(:project_id) { '20603843642073fe124fb8.14291681' }
  let(:new_project_id) { '526928826442cf2f60f643.34369791' }

  specify '#project' do
    stub(
      uri: "projects/#{project_id}",
      resp: { body: fixture('projects/project') }
    )

    project = test_client.project project_id

    expect(project).to be_an_instance_of(RubyLokaliseApi::Resources::Project)
    expect(project.project_id).to eq('20603843642073fe124fb8.14291681')
    expect(project.project_type).to eq('localization_files')
    expect(project.name).to eq('OnBoarding-2023')
    expect(project.description).to eq('')
    expect(project.created_at).to eq('2023-03-26 16:34:06 (Etc/UTC)')
    expect(project.created_at_timestamp).to eq(1_679_848_446)
    expect(project.created_by).to eq(20_181)
    expect(project.created_by_email).to eq('bodrovis@protonmail.com')
    expect(project.team_id).to eq(176_692)
    expect(project.base_language_id).to eq(640)
    expect(project.base_language_iso).to eq('en')
    expect(project.project_type).to eq('localization_files')
    expect(project.settings['per_platform_key_names']).to be false
    expect(project.statistics['progress_total']).to eq(50)
  end

  specify '#projects' do
    req_params = { page: 1, limit: 2, include_statistics: 1 }

    stub(
      uri: 'projects',
      req: { query: req_params },
      resp: {
        body: fixture('projects/projects'),
        headers: {
          'x-pagination-total-count': '55',
          'x-pagination-page-count': '28',
          'x-pagination-limit': '2',
          'x-pagination-page': '1'
        }
      }
    )

    projects = test_client.projects req_params
    expect_to_have_valid_resources(projects)

    expect(projects.collection.length).to eq(2)
    expect(projects[0].project_id).to eq('44749534644685cf3410d0.03071739')
  end

  specify '#create_project' do
    new_name = 'RubyNew'
    params = { name: new_name }

    stub(
      uri: 'projects',
      req: { body: params, verb: :post },
      resp: { body: fixture('projects/create_project') }
    )

    stub(
      uri: "projects/#{new_project_id}",
      resp: { body: fixture('projects/create_project') }
    )

    new_project = test_client.create_project(params)

    expect(new_project).to be_an_instance_of(RubyLokaliseApi::Resources::Project)
    expect(new_project.name).to eq(new_name)

    reloaded_project = new_project.reload_data

    expect(reloaded_project).to be_an_instance_of(RubyLokaliseApi::Resources::Project)
  end

  specify '#update_project' do
    params = { name: 'OnBoarding-2023', description: 'Updated description' }

    stub(
      uri: "projects/#{project_id}",
      req: { body: params, verb: :put },
      resp: { body: fixture('projects/update_project') }
    )

    stub(
      uri: "projects/#{project_id}",
      resp: { body: fixture('projects/project') }
    )

    updated_project = test_client.update_project project_id, params

    expect(updated_project).to be_an_instance_of(RubyLokaliseApi::Resources::Project)
    expect(updated_project.description).to eq(params[:description])

    reloaded_project = updated_project.reload_data

    expect(reloaded_project).to be_an_instance_of(RubyLokaliseApi::Resources::Project)
  end

  specify '#destroy_project' do
    stub(
      uri: "projects/#{new_project_id}",
      req: { verb: :delete },
      resp: { body: fixture('projects/destroy_project') }
    )

    resp = test_client.destroy_project(new_project_id)

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(new_project_id)
    expect(resp.project_deleted).to be true
  end

  specify '#empty_project' do
    project_to_empty = '7078965360db431d026791.96621226'

    stub(
      uri: "projects/#{project_to_empty}/empty",
      req: { verb: :put },
      resp: { body: fixture('projects/empty_project') }
    )

    resp = test_client.empty_project project_to_empty

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::EmptiedResource)
    expect(resp.project_id).to eq(project_to_empty)
    expect(resp.keys_deleted).to be true
  end
end
