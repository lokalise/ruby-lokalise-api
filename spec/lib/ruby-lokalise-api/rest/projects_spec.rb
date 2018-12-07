RSpec.describe Lokalise::Client do
  let(:new_project_id) { '572222075c0953fd70d492.30502628' }

  describe '#projects' do
    it 'should return all projects' do
      projects = VCR.use_cassette('all_projects') do
        test_client.projects
      end.collection
      project = projects.first

      expect(projects.count).to eq(5)
      expect(project.name).to eq('demo phoenix')
    end

    it 'should support pagination' do
      projects = VCR.use_cassette('all_projects_pagination') do
        test_client.projects limit: 1, page: 2
      end

      expect(projects.collection.count).to eq(1)
      expect(projects.total_results).to eq(5)
      expect(projects.total_pages).to eq(5)
      expect(projects.results_per_page).to eq(1)
      expect(projects.current_page).to eq(2)
    end
  end

  specify '#project' do
    project = VCR.use_cassette('project') do
      test_client.project '803826145ba90b42d5d860.46800099'
    end

    expect(project.project_id).to eq('803826145ba90b42d5d860.46800099')
    expect(project.name).to eq('demo phoenix')
    expect(project.team_id).to eq(176_692)
    expect(project.description).to eq('')
    expect(project.created_at).to eq('2018-09-24 18:05:22 (Etc/UTC)')
    expect(project.created_by).to eq(20_181)
    expect(project.created_by_email).to eq('bodrovis@protonmail.com')
  end

  specify '#create_project' do
    project = VCR.use_cassette('new_project') do
      test_client.create_project name: 'rspec proj', description: 'demo project for rspec'
    end

    expect(project.name).to eq('rspec proj')
    expect(project.description).to eq('demo project for rspec')
    expect(project.team_id).to eq(176_692)
  end

  specify '#update_project' do
    project = VCR.use_cassette('update_project') do
      test_client.update_project new_project_id,
                                 name: 'rspec proj updated', description: 'updated project for rspec'
    end

    expect(project.name).to eq('rspec proj updated')
    expect(project.description).to eq('updated project for rspec')
    expect(project.team_id).to eq(176_692)
  end

  specify '#empty_project' do
    response = VCR.use_cassette('empty_project') do
      test_client.empty_project new_project_id
    end

    expect(response['project_id']).to eq(new_project_id)
    expect(response['keys_deleted']).to eq(true)
  end

  specify '#delete_project' do
    response = VCR.use_cassette('delete_project') do
      test_client.delete_project new_project_id
    end
    expect(response['project_id']).to eq(new_project_id)
    expect(response['project_deleted']).to eq(true)
  end
end