# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::TeamUserGroups do
  let(:team_id) { 176_692 }
  let(:group_id) { 2639 }

  specify '#team_user_groups' do
    stub(
      uri: "teams/#{team_id}/groups",
      resp: { body: fixture('team_user_groups/team_user_groups') }
    )

    team_user_groups = test_client.team_user_groups team_id

    expect(team_user_groups).to be_an_instance_of(RubyLokaliseApi::Collections::TeamUserGroups)
    expect_to_have_valid_resources(team_user_groups)

    group = team_user_groups[0]

    expect(group.group_id).to eq(group_id)
  end

  specify '#team_user_group' do
    stub(
      uri: "teams/#{team_id}/groups/#{group_id}",
      resp: { body: fixture('team_user_groups/team_user_group') }
    )

    group = test_client.team_user_group team_id, group_id

    expect(group.group_id).to eq(group_id)
    expect(group.team_id).to eq(team_id)
    expect(group.name).to eq('Demo')
    expect(group.permissions['is_admin']).to be false
    expect(group.created_at).to eq('2020-07-23 11:21:04 (Etc/UTC)')
    expect(group.created_at_timestamp).to eq(1_595_503_264)
    expect(group.projects).to eq([])
    expect(group.members).to include(49_436)
    expect(group.role_id).to eq(5)
  end

  specify '#create_team_user_group' do
    group_data = {
      name: 'SDK',
      is_reviewer: true,
      is_admin: false,
      languages: {
        reference: [],
        contributable: [640]
      }
    }

    stub(
      uri: "teams/#{team_id}/groups",
      req: { body: group_data, verb: :post },
      resp: { body: fixture('team_user_groups/create_team_user_group') }
    )

    group = test_client.create_team_user_group team_id, group_data

    expect(group.team_id).to eq(team_id)
    expect(group.name).to eq(group_data[:name])
    expect(group.permissions['is_admin']).to eq(group_data[:is_admin])
  end

  specify '#update_team_user_group' do
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

    group = test_client.update_team_user_group team_id, group_id, group_data

    expect(group.team_id).to eq(team_id)
    expect(group.group_id).to eq(group_id)
    expect(group.name).to eq(group_data[:name])
    expect(group.permissions['is_admin']).to eq(group_data[:is_admin])
  end

  specify '#add_projects_to_group' do
    project_ids = %w[963054665b7c313dd9b323.35886655 2273827860c1e2473eb195.11207948]

    stub(
      uri: "teams/#{team_id}/groups/#{group_id}/projects/add",
      req: { body: { projects: project_ids }, verb: :put },
      resp: { body: fixture('team_user_groups/add_projects_to_group') }
    )

    group = test_client.add_projects_to_group team_id, group_id, project_ids

    expect(group.team_id).to eq(team_id)
    expect(group.group_id).to eq(group_id)
    expect(group.projects).to include(*project_ids)
  end

  specify '#remove_projects_from_group' do
    project_ids = %w[963054665b7c313dd9b323.35886655]

    stub(
      uri: "teams/#{team_id}/groups/#{group_id}/projects/remove",
      req: { body: { projects: project_ids }, verb: :put },
      resp: { body: fixture('team_user_groups/remove_projects_from_group') }
    )

    group = test_client.remove_projects_from_group team_id, group_id, project_ids

    expect(group.team_id).to eq(team_id)
    expect(group.group_id).to eq(group_id)
    expect(group.projects).not_to include(*project_ids)
  end

  specify '#add_members_to_group' do
    user_ids = [140_889, 132_650]

    stub(
      uri: "teams/#{team_id}/groups/#{group_id}/members/add",
      req: { body: { users: user_ids }, verb: :put },
      resp: { body: fixture('team_user_groups/add_members_to_group') }
    )

    group = test_client.add_members_to_group team_id, group_id, user_ids

    expect(group.team_id).to eq(team_id)
    expect(group.group_id).to eq(group_id)
    expect(group.members).to include(*user_ids)
  end

  specify '#remove_members_from_group' do
    user_ids = 140_889

    stub(
      uri: "teams/#{team_id}/groups/#{group_id}/members/remove",
      req: { body: { users: [user_ids] }, verb: :put },
      resp: { body: fixture('team_user_groups/remove_members_from_group') }
    )

    group = test_client.remove_members_from_group team_id, group_id, user_ids

    expect(group.team_id).to eq(team_id)
    expect(group.group_id).to eq(group_id)
    expect(group.members).not_to include(user_ids)
  end

  specify '#destroy_team_user_group' do
    stub(
      uri: "teams/#{team_id}/groups/#{group_id}",
      req: { verb: :delete },
      resp: { body: fixture('team_user_groups/destroy_team_user_group') }
    )

    resp = test_client.destroy_team_user_group team_id, group_id

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.team_id).to eq(team_id)
    expect(resp.group_deleted).to be true
  end
end
