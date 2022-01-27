# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:snapshot_id) { 27_881 }

  describe '#snapshots' do
    it 'returns all snapshots' do
      snapshots = VCR.use_cassette('all_snapshots') do
        test_client.snapshots project_id
      end.collection

      snapshot = snapshots.first

      expect(snapshots.count).to eq(1)
      expect(snapshot.title).to eq('test rspec')
      expect(snapshot.snapshot_id).to eq(27_882)
      expect(snapshot.created_at).to eq('2018-12-10 17:02:04 (Etc/UTC)')
      expect(snapshot.created_by).to eq(20_181)
      expect(snapshot.created_by_email).to eq('bodrovis@protonmail.com')
      expect(snapshot.created_at_timestamp).to eq(1_544_461_324)
    end

    it 'supports pagination' do
      snapshots = VCR.use_cassette('all_snapshots_pagination') do
        test_client.snapshots project_id, limit: 1, page: 2
      end

      expect(snapshots.collection.count).to eq(1)
      expect(snapshots.total_results).to eq(2)
      expect(snapshots.total_pages).to eq(2)
      expect(snapshots.results_per_page).to eq(1)
      expect(snapshots.current_page).to eq(2)

      expect(snapshots.next_page?).to eq(false)
      expect(snapshots.last_page?).to eq(true)
      expect(snapshots.prev_page?).to eq(true)
      expect(snapshots.first_page?).to eq(false)
    end
  end

  specify '#create_snapshot' do
    snapshot = VCR.use_cassette('create_snapshot') do
      test_client.create_snapshot project_id, title: 'test rspec'
    end

    expect(snapshot.title).to eq('test rspec')
  end

  specify '#restore_snapshot' do
    project = VCR.use_cassette('restore_snapshot') do
      test_client.restore_snapshot project_id, snapshot_id
    end

    expect(project.name).to eq('demo phoenix copy')
    expect(project.created_by_email).to eq('bodrovis@protonmail.com')
    # Restore creates a new copy of the project!
    expect(project.project_id).not_to eq(project_id)
  end

  specify '#destroy_snapshot' do
    response = VCR.use_cassette('delete_snapshot') do
      test_client.destroy_snapshot project_id, snapshot_id
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['snapshot_deleted']).to eq(true)
  end

  context 'when snapshot methods are chained' do
    it 'allows restored project to receive chained methods' do
      snapshot = VCR.use_cassette('create_snapshot_for_chained') do
        test_client.create_snapshot project_id, title: 'chained rspec snap'
      end

      new_project = VCR.use_cassette('restore_snapshot_for_chained') do
        snapshot.restore
      end

      updated_project = VCR.use_cassette('restored_updated_project') do
        new_project.update name: 'Restored and updated'
      end

      expect(updated_project.client.token).to eq(test_client.token)
      expect(updated_project.name).to eq('Restored and updated')
      expect(updated_project.project_id).to eq(new_project.project_id)

      response = VCR.use_cassette('delete_restored_project') do
        updated_project.destroy
      end

      expect(response['project_id']).to eq(updated_project.project_id)
      expect(response['project_deleted']).to eq(true)
    end

    it 'supports destroy and restore' do
      snapshot = VCR.use_cassette('create_another_snapshot') do
        test_client.create_snapshot project_id, title: 'chained'
      end

      expect(snapshot.title).to eq('chained')

      restored_project = VCR.use_cassette('restore_snapshot_chained') do
        snapshot.restore
      end

      expect(restored_project.name).to eq('demo phoenix copy')

      delete_response = VCR.use_cassette('delete_snapshot_chained') do
        snapshot.destroy
      end

      expect(delete_response['project_id']).to eq(project_id)
      expect(delete_response['snapshot_deleted']).to eq(true)
    end
  end
end
