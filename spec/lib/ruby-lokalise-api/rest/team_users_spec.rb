# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:team_id) { 176_692 }
  let(:team_user_id) { 25_953 }
  let(:another_user_id) { 26_265 }

  describe '#team_users' do
    it 'returns all team_users' do
      team_users = VCR.use_cassette('team_users') do
        test_client.team_users team_id
      end

      expect(team_users.collection.count).to eq(4)
      expect(team_users.team_id).to eq(team_id)
    end

    it 'supports pagination' do
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
      test_client.team_user team_id, '20181'
    end

    expect(team_user.user_id).to eq(20_181)
    expect(team_user.email).to eq('bodrovis@protonmail.com')
    expect(team_user.fullname).to eq('Ilya B')
    expect(team_user.created_at).to eq('2018-08-21 15:35:25 (Etc/UTC)')
    expect(team_user.created_at_timestamp).to eq(1_534_865_725)
    expect(team_user.role).to eq('owner')
  end

  specify '#reload_data' do
    team_user = VCR.use_cassette('team_user') do
      test_client.team_user team_id, '20181'
    end

    reloaded_team_user = VCR.use_cassette('team_user') do
      team_user.reload_data
    end

    expect(reloaded_team_user.user_id).to eq(team_user.user_id)
  end

  specify '#update_team_user' do
    team_user = VCR.use_cassette('update_team_user') do
      test_client.update_team_user team_id, team_user_id, role: 'admin'
    end

    expect(team_user.user_id).to eq(team_user_id)
    expect(team_user.role).to eq('admin')
  end

  specify '#destroy_team_user' do
    response = VCR.use_cassette('delete_team_user') do
      test_client.destroy_team_user team_id, team_user_id
    end
    expect(response['team_id']).to eq(team_id)
    expect(response['team_user_deleted']).to eq(true)
  end

  context 'when team user methods are chained' do
    it 'supports update and destroy' do
      team_user = VCR.use_cassette('another_team_user') do
        test_client.team_user team_id, another_user_id
      end

      updated_team_user = VCR.use_cassette('update_team_user_chained') do
        team_user.update role: 'admin'
      end

      expect(updated_team_user.client).to eq(test_client)
      expect(updated_team_user.role).to eq('admin')

      delete_response = VCR.use_cassette('delete_team_user_chained') do
        updated_team_user.destroy
      end

      expect(delete_response['team_id']).to eq(team_id)
      expect(delete_response['team_user_deleted']).to eq(true)
    end
  end
end
