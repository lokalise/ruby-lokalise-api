# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:team_id) { 176_692 }
  let(:group_id) { 515 }
  let(:second_group_id) { 690 }
  let(:third_group_id) { 689 }
  let(:project_id) { '605317925c13e4ecb36a79.94825279' }
  let(:another_project_id) { '446952185c01a12b4d0b45.76217122' }
  let(:user_id) { 35_554 }

  describe '#team_user_groups' do
    it 'returns all team_user_groups' do
      team_user_groups = VCR.use_cassette('team_user_groups') do
        test_client.team_user_groups team_id
      end

      expect(team_user_groups.collection.count).to eq(2)
      expect(team_user_groups.team_id).to eq(team_id)
    end

    it 'supports pagination' do
      team_users = VCR.use_cassette('team_user_groups_pagination') do
        test_client.team_user_groups team_id, limit: 1, page: 2
      end

      expect(team_users.collection.count).to eq(1)
      expect(team_users.total_results).to eq(2)
      expect(team_users.total_pages).to eq(2)
      expect(team_users.results_per_page).to eq(1)
      expect(team_users.current_page).to eq(2)
    end
  end

  specify '#team_user_group' do
    group = VCR.use_cassette('team_user_group') do
      test_client.team_user_group team_id, group_id
    end

    expect(group.group_id).to eq(group_id)
    expect(group.name).to eq('Demo')
    expect(group.permissions['is_admin']).to eq(true)
    expect(group.created_at).to eq('2019-03-19 19:53:04 (Etc/UTC)')
    expect(group.created_at_timestamp).to eq(1_553_025_184)
    expect(group.team_id).to eq(team_id)
    expect(group.projects.first).to eq('803826145ba90b42d5d860.46800099')
    expect(group.members[1]).to eq(25_753)

    reloaded_group = VCR.use_cassette('team_user_group') do
      group.reload_data
    end
    expect(reloaded_group.group_id).to eq(group.group_id)
  end

  specify '#create_team_user_group' do
    group = VCR.use_cassette('create_team_user_group') do
      test_client.create_team_user_group team_id, name: 'RSpec group',
                                                  is_reviewer: false,
                                                  is_admin: false,
                                                  languages: {
                                                    reference: [],
                                                    contributable: [640]
                                                  }
    end

    expect(group.name).to eq('RSpec group')
    expect(group.team_id).to eq(team_id)

    reloaded_group = VCR.use_cassette('created_team_user_group') do
      group.reload_data
    end
    expect(reloaded_group.group_id).to eq(group.group_id)
  end

  specify '#update_team_user_group' do
    group = VCR.use_cassette('update_team_user_group') do
      test_client.update_team_user_group team_id, second_group_id,
                                         name: 'updated rspec', is_admin: true,
                                         is_reviewer: true
    end

    expect(group.name).to eq('updated rspec')
    expect(group.team_id).to eq(team_id)
    expect(group.permissions['is_admin']).to eq(true)
    expect(group.permissions['is_reviewer']).to eq(true)
  end

  specify '#destroy_team_user_group' do
    response = VCR.use_cassette('destroy_team_user_group') do
      test_client.destroy_team_user_group team_id, second_group_id
    end
    expect(response['team_id']).to eq(team_id)
    expect(response['group_deleted']).to eq(true)
  end

  specify '#add_projects_to_group' do
    group = VCR.use_cassette('add_projects_to_group') do
      test_client.add_projects_to_group team_id, third_group_id, project_id
    end

    expect(group.team_id).to eq(team_id)
    expect(group.group_id).to eq(third_group_id)
    expect(group.projects).to include(project_id)

    reloaded_group = VCR.use_cassette('another_team_user_group') do
      group.reload_data
    end
    expect(reloaded_group.group_id).to eq(group.group_id)

    group = VCR.use_cassette('add_projects_to_group') do
      group.add_projects projects: [project_id]
    end
    expect(group.group_id).to eq(third_group_id)
  end

  specify '#remove_projects_from_group' do
    group = VCR.use_cassette('remove_projects_from_group') do
      test_client.remove_projects_from_group team_id, third_group_id, another_project_id
    end

    expect(group.group_id).to eq(third_group_id)
    expect(group.team_id).to eq(team_id)
    expect(group.projects).to be_empty

    reloaded_group = VCR.use_cassette('another_team_user_group') do
      group.reload_data
    end
    expect(reloaded_group.group_id).to eq(group.group_id)

    group = VCR.use_cassette('remove_projects_from_group') do
      group.remove_projects projects: [project_id]
    end
    expect(group.group_id).to eq(third_group_id)
  end

  specify '#add_users_to_group' do
    group = VCR.use_cassette('add_users_to_group') do
      test_client.add_users_to_group team_id, third_group_id, user_id
    end

    expect(group.team_id).to eq(team_id)
    expect(group.group_id).to eq(third_group_id)
    expect(group.members).to include(user_id)

    reloaded_group = VCR.use_cassette('another_team_user_group') do
      group.reload_data
    end
    expect(reloaded_group.group_id).to eq(group.group_id)

    group = VCR.use_cassette('add_users_to_group') do
      group.add_users users: [user_id]
    end
  end

  specify '#remove_users_from_group' do
    group = VCR.use_cassette('remove_users_from_group') do
      test_client.remove_users_from_group team_id, third_group_id, user_id
    end

    expect(group.group_id).to eq(third_group_id)
    expect(group.team_id).to eq(team_id)
    expect(group.members).to be_empty

    reloaded_group = VCR.use_cassette('another_team_user_group') do
      group.reload_data
    end
    expect(reloaded_group.group_id).to eq(group.group_id)

    group = VCR.use_cassette('remove_users_from_group') do
      group.remove_users users: [user_id]
    end
  end

  context 'when team user group methods are chained' do
    it 'supports update and destroy' do
      group = VCR.use_cassette('another_team_user_group') do
        test_client.team_user_group team_id, third_group_id
      end

      expect(group.group_id).to eq(third_group_id)

      group = VCR.use_cassette('update_another_team_user_group') do
        group.update name: 'another group updated', is_admin: true, is_reviewer: true
      end

      expect(group.group_id).to eq(third_group_id)
      expect(group.permissions['is_admin']).to eq(true)
      expect(group.name).to eq('another group updated')

      response = VCR.use_cassette('destroy_another_team_user_group') do
        group.destroy
      end

      expect(response['team_id']).to eq(team_id)
      expect(response['group_deleted']).to eq(true)
    end

    it 'supports project management' do
      group = VCR.use_cassette('team_user_group') do
        test_client.team_user_group team_id, group_id
      end

      group = VCR.use_cassette('add_project_to_group_chained') do
        group.add_projects(projects: [another_project_id])
      end

      expect(group.team_id).to eq(team_id)
      expect(group.group_id).to eq(group_id)
      expect(group.projects).to include(another_project_id)

      group = VCR.use_cassette('add_project_to_group_chained') do
        group.add_projects(projects: [another_project_id])
      end

      reloaded_group = VCR.use_cassette('team_user_group') do
        group.reload_data
      end
      expect(reloaded_group.group_id).to eq(group.group_id)

      group = VCR.use_cassette('remove_project_from_group_chained') do
        group.remove_projects(projects: [another_project_id])
      end

      expect(group.team_id).to eq(team_id)
      expect(group.group_id).to eq(group_id)
      expect(group.projects).not_to include(another_project_id)

      group = VCR.use_cassette('remove_project_from_group_chained') do
        group.remove_projects(projects: [another_project_id])
      end

      reloaded_group = VCR.use_cassette('team_user_group') do
        group.reload_data
      end
      expect(reloaded_group.group_id).to eq(group.group_id)
    end

    it 'supports users management' do
      group = VCR.use_cassette('team_user_group') do
        test_client.team_user_group team_id, group_id
      end

      group = VCR.use_cassette('add_user_to_group_chained') do
        group.add_users(users: [user_id])
      end

      expect(group.team_id).to eq(team_id)
      expect(group.group_id).to eq(group_id)
      expect(group.members).to include(user_id)

      group = VCR.use_cassette('add_user_to_group_chained') do
        group.add_users(users: [user_id])
      end

      reloaded_group = VCR.use_cassette('team_user_group') do
        group.reload_data
      end
      expect(reloaded_group.group_id).to eq(group.group_id)

      group = VCR.use_cassette('remove_user_from_group_chained') do
        group.remove_users(users: [user_id])
      end

      expect(group.team_id).to eq(team_id)
      expect(group.group_id).to eq(group_id)
      expect(group.members).not_to include(user_id)

      group = VCR.use_cassette('remove_user_from_group_chained') do
        group.remove_users(users: [user_id])
      end

      reloaded_group = VCR.use_cassette('team_user_group') do
        group.reload_data
      end
      expect(reloaded_group.group_id).to eq(group.group_id)
    end
  end
end
