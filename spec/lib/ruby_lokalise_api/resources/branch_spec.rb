# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Branch do
  let(:branch_fixture) { loaded_fixture('branches/branch') }
  let(:project_id) { branch_fixture['project_id'] }
  let(:branch_id) { branch_fixture['branch']['branch_id'] }
  let(:ep) { endpoint name: 'Branches', client: test_client, params: { query: [project_id, branch_id] } }
  let(:branch) { resource 'Branch', response(branch_fixture, ep) }

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/branches/#{branch_id}",
      resp: { body: fixture('branches/branch') }
    )

    reloaded_branch = branch.reload_data

    expect(reloaded_branch.branch_id).to eq(branch_id)
    expect(reloaded_branch.project_id).to eq(project_id)
  end

  specify '#update' do
    branch_data = {
      name: 'Ruby_updated'
    }

    stub(
      uri: "projects/#{project_id}/branches/#{branch_id}",
      req: { body: branch_data, verb: :put },
      resp: { body: fixture('branches/update_branch') }
    )

    updated_branch = branch.update branch_data

    expect(updated_branch).to be_an_instance_of(described_class)
    expect(updated_branch.name).to eq(branch_data[:name])
    expect(updated_branch.branch_id).to eq(branch_id)
  end

  specify '#destroy' do
    stub(
      uri: "projects/#{project_id}/branches/#{branch_id}",
      req: { verb: :delete },
      resp: { body: fixture('branches/destroy_branch') }
    )

    resp = branch.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.branch_deleted).to be true
  end

  specify '#merge' do
    second_branch_fixture = loaded_fixture('branches/branch2')
    branch_id2 = second_branch_fixture['branch']['branch_id']

    merge_endpoint = endpoint name: 'Branches', client: test_client, params: { query: [project_id, branch_id2] }
    branch_source = resource 'Branch', response(second_branch_fixture, merge_endpoint)

    merge_target = 324_738

    data = {
      force_conflict_resolve_using: 'source',
      target_branch_id: merge_target
    }

    stub(
      uri: "projects/#{project_id}/branches/#{branch_id2}/merge",
      req: { body: data, verb: :post },
      resp: { body: fixture('branches/merge_branch') }
    )

    resp = branch_source.merge data

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::MergedBranches)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch['branch_id']).to eq(branch_id2)
  end
end
