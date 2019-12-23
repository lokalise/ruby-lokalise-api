# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:branch_id) { 41_302 }

  describe '#branches' do
    it 'returns all branches' do
      branches = VCR.use_cassette('all_branches') do
        test_client.branches project_id
      end.collection

      expect(branches.count).to eq(1)
    end

    it 'supports pagination' do
      branches = VCR.use_cassette('all_branches_pagination') do
        test_client.branches project_id, limit: 1, page: 1
      end

      expect(branches.collection.count).to eq(1)
      expect(branches.total_results).to eq(1)
      expect(branches.total_pages).to eq(1)
      expect(branches.results_per_page).to eq(1)
      expect(branches.current_page).to eq(1)
      expect(branches.collection.first.name).to eq('ruby-branch')
    end
  end

  specify '#branch' do
    branch = VCR.use_cassette('branch') do
      test_client.branch project_id, branch_id
    end

    expect(branch.branch_id).to eq(branch_id)
    expect(branch.name).to eq('ruby-branch')
    expect(branch.created_at).to eq('2019-10-30 14:24:41 (Etc/UTC)')
    expect(branch.created_at_timestamp).to eq(1_572_445_481)
    expect(branch.created_by).to eq(20_181)
    expect(branch.created_by_email).to eq('bodrovis@protonmail.com')
  end

  specify '#create_branch' do
    branch = VCR.use_cassette('create_branch') do
      test_client.create_branch project_id, name: 'ruby-branch'
    end

    expect(branch.name).to eq('ruby-branch')
  end

  specify '#update_branch' do
    branch = VCR.use_cassette('update_branch') do
      test_client.update_branch project_id, branch_id, name: 'updated-ruby-branch'
    end

    expect(branch.name).to eq('updated-ruby-branch')
  end

  specify '#destroy_branch' do
    response = VCR.use_cassette('destroy_branch') do
      test_client.destroy_branch project_id, branch_id
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['branch_deleted']).to eq(true)
  end

  specify '#merge_branch' do
    branch = VCR.use_cassette('create_branch_to_merge') do
      test_client.create_branch project_id, name: 'merge-me'
    end

    expect(branch.name).to eq('merge-me')

    branch_id = branch.branch_id

    response = VCR.use_cassette('merge_branch') do
      test_client.merge_branch project_id, branch_id, force_conflict_resolve_using: 'master'
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['branch_merged']).to eq(true)
    expect(response['branch']['branch_id']).to eq(branch_id)
    expect(response['branch']['name']).to eq(branch.name)
  end

  context 'when branch methods are chained' do
    it 'supports merge' do
      branch = VCR.use_cassette('create_branch_to_merge2') do
        test_client.create_branch project_id, name: 'merge-me-plz'
      end

      expect(branch.name).to eq('merge-me-plz')

      branch_id = branch.branch_id

      response = VCR.use_cassette('merge_branch_chained') do
        branch.merge force_conflict_resolve_using: 'master'
      end

      expect(response['project_id']).to eq(project_id)
      expect(response['branch_merged']).to eq(true)
      expect(response['branch']['branch_id']).to eq(branch_id)
      expect(response['branch']['name']).to eq(branch.name)
    end

    it 'supports update and destroy' do
      branch = VCR.use_cassette('create_another_branch') do
        test_client.create_branch project_id, name: 'ruby-second-branch'
      end

      expect(branch.name).to eq('ruby-second-branch')

      branch = VCR.use_cassette('update_another_branch') do
        branch.update name: 'updated-ruby-second-branch'
      end

      expect(branch.name).to eq('updated-ruby-second-branch')

      response = VCR.use_cassette('destroy_another_branch') do
        branch.destroy
      end

      expect(response['project_id']).to eq(project_id)
      expect(response['branch_deleted']).to eq(true)
    end
  end
end
