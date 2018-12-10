RSpec.describe Lokalise::Client do
  let(:team_id) { 176_692 }
  let(:team_user_id) { 25_953 }

  describe '#team_users' do
    it 'should return all team_users' do
      team_users = VCR.use_cassette('team_users') do
        test_client.team_users team_id
      end

      expect(team_users.collection.count).to eq(4)
      expect(team_users.team_id).to eq(team_id)
    end

    it 'should support pagination' do
      team_users = VCR.use_cassette('all_team_users_pagination') do
        test_client.team_users team_id, limit: 1, page: 3
      end

      expect(team_users.collection.count).to eq(1)
      expect(team_users.total_results).to eq(4)
      expect(team_users.total_pages).to eq(4)
      expect(team_users.results_per_page).to eq(1)
      expect(team_users.current_page).to eq(3)
    end
  end

  specify '#team_user' do
    team_user = VCR.use_cassette('team_user') do
      test_client.team_user team_id, team_user_id
    end

    expect(team_user.user_id).to eq(team_user_id)
    expect(team_user.email).to eq('rspec@test.com')
    expect(team_user.fullname).to eq('Rspec test')
    expect(team_user.created_at).to eq('2018-12-07 18:21:24 (Etc/UTC)')
    expect(team_user.role).to eq('member')
  end

  specify '#update_team_user' do
    team_user = VCR.use_cassette('update_team_user') do
      test_client.update_team_user team_id, team_user_id, role: 'admin'
    end

    expect(team_user.user_id).to eq(team_user_id)
    expect(team_user.role).to eq('admin')
  end

  specify '#delete_team_user' do
    response = VCR.use_cassette('delete_team_user') do
      test_client.delete_team_user team_id, team_user_id
    end
    expect(response['team_id']).to eq(team_id)
    expect(response['team_user_deleted']).to eq(true)
  end
end
