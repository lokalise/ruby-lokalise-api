# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Snapshots do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:snapshot_id) { 2_296_294 }

  specify '#snapshots' do
    stub(
      uri: "projects/#{project_id}/snapshots",
      resp: { body: fixture('snapshots/snapshots') }
    )

    snapshots = test_client.snapshots project_id

    expect(snapshots.collection.length).to eq(3)
    expect_to_have_valid_resources(snapshots)
    expect(snapshots.project_id).to eq(project_id)
    expect(snapshots.branch).to eq('master')

    snapshot = snapshots[0]

    expect(snapshot.snapshot_id).to eq(2_130_183)
  end

  specify '#create_snapshot' do
    snapshot_data = {
      title: 'Ruby SDK'
    }

    stub(
      uri: "projects/#{project_id}/snapshots",
      req: { body: snapshot_data, verb: :post },
      resp: { body: fixture('snapshots/create_snapshot') }
    )

    snapshot = test_client.create_snapshot project_id, snapshot_data

    expect(snapshot).to be_an_instance_of(RubyLokaliseApi::Resources::Snapshot)
    expect(snapshot.title).to eq(snapshot_data[:title])
    expect(snapshot.branch).to eq('master')
  end

  specify '#restore_snapshot' do
    stub(
      uri: "projects/#{project_id}/snapshots/#{snapshot_id}",
      req: { verb: :post },
      resp: { body: fixture('snapshots/restore_snapshot') }
    )

    restored_project = test_client.restore_snapshot project_id, snapshot_id

    expect(restored_project).to be_an_instance_of(RubyLokaliseApi::Resources::Project)
    expect(restored_project.name).to eq('OnBoarding-2023 copy')
    expect(restored_project.project_id).not_to eq(project_id)

    endpoint = restored_project.instance_variable_get(:@self_endpoint)
    expect(endpoint).to be_an_instance_of(RubyLokaliseApi::Endpoints::ProjectsEndpoint)
    expect(endpoint.uri).to include('projects', project_id)
    expect(endpoint.uri).not_to include('snapshots')
  end

  specify '#destroy_snapshot' do
    stub(
      uri: "projects/#{project_id}/snapshots/#{snapshot_id}",
      req: { verb: :delete },
      resp: { body: fixture('snapshots/destroy_snapshot') }
    )

    resp = test_client.destroy_snapshot project_id, snapshot_id

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.snapshot_deleted).to be true
  end
end
