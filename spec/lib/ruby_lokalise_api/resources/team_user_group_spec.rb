# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::TeamUserGroup do
  let(:team_id) { 176_692 }

  let(:loaded_group_fixture) { loaded_fixture('team_user_groups/team_user_group') }

  let(:group_id) { loaded_group_fixture['group_id'] }

  let(:group_endpoint) do
    endpoint name: 'TeamUserGroups', client: test_client, params: { query: [team_id, group_id] }
  end

  let(:group) do
    resource 'TeamUserGroup', response(loaded_group_fixture, group_endpoint)
  end

  specify '#reload_data' do
    stub(
      uri: "teams/#{team_id}/groups/#{group_id}",
      resp: { body: fixture('team_user_groups/team_user_group') }
    )

    reloaded_group = group.reload_data

    expect(reloaded_group).to be_an_instance_of(described_class)
    expect(reloaded_group.group_id).to eq(group_id)
  end

  specify '#update' do
    group_data = {
      name: 'Updated SDK',
      is_reviewer: true,
      is_admin: false,
      languages: {
        reference: [],
        contributable: [640]
      }
    }

    stub(
      uri: "teams/#{team_id}/groups/#{group_id}",
      req: { body: group_data, verb: :put },
      resp: { body: fixture('team_user_groups/update_team_user_group') }
    )

    updated_group = group.update group_data

    expect(updated_group.team_id).to eq(team_id)
    expect(updated_group.group_id).to eq(group_id)
    expect(updated_group.name).to eq(group_data[:name])
    expect(updated_group.permissions['is_admin']).to eq(group_data[:is_admin])
  end

  specify '#add_projects' do
    project_ids = %w[963054665b7c313dd9b323.35886655 2273827860c1e2473eb195.11207948]

    stub(
      uri: "teams/#{team_id}/groups/#{group_id}/projects/add",
      req: { body: { projects: project_ids }, verb: :put },
      resp: { body: fixture('team_user_groups/add_projects_to_group') }
    )

    updated_group = group.add_projects project_ids

    expect(updated_group.team_id).to eq(team_id)
    expect(updated_group.group_id).to eq(group_id)
    expect(updated_group.projects).to include(*project_ids)
  end

  specify '#remove_projects' do
    project_ids = %w[963054665b7c313dd9b323.35886655]

    stub(
      uri: "teams/#{team_id}/groups/#{group_id}/projects/remove",
      req: { body: { projects: project_ids }, verb: :put },
      resp: { body: fixture('team_user_groups/remove_projects_from_group') }
    )

    updated_group = group.remove_projects project_ids

    expect(updated_group.team_id).to eq(team_id)
    expect(updated_group.group_id).to eq(group_id)
    expect(updated_group.projects).not_to include(*project_ids)
  end

  specify '#add_members' do
    user_ids = [140_889, 132_650]

    stub(
      uri: "teams/#{team_id}/groups/#{group_id}/members/add",
      req: { body: { users: user_ids }, verb: :put },
      resp: { body: fixture('team_user_groups/add_members_to_group') }
    )

    updated_group = group.add_members user_ids

    expect(updated_group.team_id).to eq(team_id)
    expect(updated_group.group_id).to eq(group_id)
    expect(updated_group.members).to include(*user_ids)
  end

  specify '#remove_members' do
    user_ids = 140_889

    stub(
      uri: "teams/#{team_id}/groups/#{group_id}/members/remove",
      req: { body: { users: [user_ids] }, verb: :put },
      resp: { body: fixture('team_user_groups/remove_members_from_group') }
    )

    updated_group = group.remove_members user_ids

    expect(updated_group.team_id).to eq(team_id)
    expect(updated_group.group_id).to eq(group_id)
    expect(updated_group.members).not_to include(user_ids)
  end

  specify '#destroy' do
    stub(
      uri: "teams/#{team_id}/groups/#{group_id}",
      req: { verb: :delete },
      resp: { body: fixture('team_user_groups/destroy_team_user_group') }
    )

    resp = group.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.team_id).to eq(team_id)
    expect(resp.group_deleted).to be true
  end
end
