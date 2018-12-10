RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:snapshot_id) { 27881 }

  describe '#snapshots' do
    it 'should return all snapshots' do
      snapshots = VCR.use_cassette('all_snapshots') do
        test_client.snapshots project_id
      end.collection

      snapshot = snapshots.first

      expect(snapshots.count).to eq(2)
      expect(snapshot.title).to eq('test')
      expect(snapshot.snapshot_id).to eq(snapshot_id)
      expect(snapshot.created_at).to eq('2018-12-10 17:01:48 (Etc/UTC)')
      expect(snapshot.created_by).to eq(20181)
      expect(snapshot.created_by_email).to eq('bodrovis@protonmail.com')
    end

    it 'should support pagination' do
      snapshots = VCR.use_cassette('all_snapshots_pagination') do
        test_client.snapshots project_id, limit: 1, page: 2
      end

      expect(snapshots.collection.count).to eq(1)
      expect(snapshots.total_results).to eq(2)
      expect(snapshots.total_pages).to eq(2)
      expect(snapshots.results_per_page).to eq(1)
      expect(snapshots.current_page).to eq(2)
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

  specify '#delete_snapshot' do
    response = VCR.use_cassette('delete_snapshot') do
      test_client.delete_snapshot project_id, snapshot_id
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['snapshot_deleted']).to eq(true)
  end
end
