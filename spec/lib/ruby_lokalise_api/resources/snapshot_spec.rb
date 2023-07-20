# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Snapshot do
  let(:project_id) { '88628569645b945648b474.25982965' }

  let(:loaded_snapshots_fixture) { loaded_fixture('snapshots/snapshots') }

  let(:snapshots) do
    collection 'Snapshots', response(loaded_snapshots_fixture, snapshots_endpoint)
  end

  let(:snapshots_endpoint) do
    params = { query: project_id }
    endpoint name: 'Snapshots', client: test_client, params: params
  end

  it 'does not support update' do
    expect(snapshots[0]).not_to respond_to(:update)
  end

  it 'does not support reload_data' do
    expect(snapshots[0]).not_to respond_to(:reload_data)
  end

  specify '#restore' do
    stub(
      uri: "projects/#{project_id}/snapshots/#{snapshots[0].snapshot_id}",
      req: { verb: :post },
      resp: { body: fixture('snapshots/restore_snapshot2') }
    )

    restored_project = snapshots[0].restore

    expect(restored_project).to be_an_instance_of(RubyLokaliseApi::Resources::Project)
    expect(restored_project.name).to eq('OnBoarding-2023 copy')
    expect(restored_project.project_id).not_to eq(project_id)

    endpoint = restored_project.instance_variable_get(:@self_endpoint)
    expect(endpoint).to be_an_instance_of(RubyLokaliseApi::Endpoints::ProjectsEndpoint)
    expect(endpoint.uri).to include('projects', project_id)
    expect(endpoint.uri).not_to include('snapshots')
  end

  specify '#destroy' do
    stub(
      uri: "projects/#{project_id}/snapshots/#{snapshots[0].snapshot_id}",
      req: { verb: :delete },
      resp: { body: fixture('snapshots/destroy_snapshot') }
    )

    resp = snapshots[0].destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.snapshot_deleted).to be true
  end
end
