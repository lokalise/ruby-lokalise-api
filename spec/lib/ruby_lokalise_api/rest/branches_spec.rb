# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Branches do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:branch_id) { 324_739 }

  specify '#branches' do
    stub(
      uri: "projects/#{project_id}/branches",
      resp: { body: fixture('branches/branches') }
    )

    branches = test_client.branches project_id

    expect(branches.collection.length).to eq(3)
    expect_to_have_valid_resources(branches)
    expect(branches.project_id).to eq(project_id)
    expect(branches.branch).to eq('master')

    branch = branches.first

    expect(branch.branch_id).to eq(324_739)
  end

  specify '#branch' do
    stub(
      uri: "projects/#{project_id}/branches/#{branch_id}",
      resp: { body: fixture('branches/branch') }
    )

    branch = test_client.branch project_id, branch_id

    expect(branch.branch_id).to eq(branch_id)
    expect(branch.project_id).to eq(project_id)
    expect(branch.name).to eq('demo')
    expect(branch[:name]).to eq('demo')
    expect(branch.created_at).to eq('2023-07-11 16:48:04 (Etc/UTC)')
    expect(branch.created_at_timestamp).to eq(1_689_094_084)
    expect(branch.created_by).to eq(20_181)
    expect(branch.created_by_email).to eq('bodrovis@protonmail.com')
  end

  specify '#create_branch' do
    branch_data = {
      name: 'Ruby_SDK'
    }

    stub(
      uri: "projects/#{project_id}/branches",
      req: { body: branch_data, verb: :post },
      resp: { body: fixture('branches/create_branch') }
    )

    branch = test_client.create_branch project_id, branch_data

    expect(branch).to be_an_instance_of(RubyLokaliseApi::Resources::Branch)
    expect(branch.name).to eq(branch_data[:name])
    expect(branch.project_id).to eq(project_id)
  end

  specify '#update_branch' do
    branch_data = {
      name: 'Ruby_updated'
    }

    stub(
      uri: "projects/#{project_id}/branches/#{branch_id}",
      req: { body: branch_data, verb: :put },
      resp: { body: fixture('branches/update_branch') }
    )

    branch = test_client.update_branch project_id, branch_id, branch_data

    expect(branch).to be_an_instance_of(RubyLokaliseApi::Resources::Branch)
    expect(branch.name).to eq(branch_data[:name])
    expect(branch.branch_id).to eq(branch_id)
  end

  specify '#destroy_branch' do
    stub(
      uri: "projects/#{project_id}/branches/#{branch_id}",
      req: { verb: :delete },
      resp: { body: fixture('branches/destroy_branch') }
    )

    resp = test_client.destroy_branch project_id, branch_id

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.branch_deleted).to be true
  end

  specify '#merge_branch' do
    merge_source = 324_747
    merge_target = 324_738
    data = {
      force_conflict_resolve_using: 'source',
      target_branch_id: merge_target
    }

    stub(
      uri: "projects/#{project_id}/branches/#{merge_source}/merge",
      req: { body: data, verb: :post },
      resp: { body: fixture('branches/merge_branch') }
    )

    resp = test_client.merge_branch project_id, merge_source, data

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::MergedBranches)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch['branch_id']).to eq(merge_source)
  end
end
