RSpec.describe Lokalise::Client do
  describe '#projects' do
    it 'should return all projects' do
      projects = VCR.use_cassette('all_projects') do
        test_client.projects
      end.content['projects']
      project = projects[0]

      expect(projects.count).to eq(5)
      expect(project['name']).to eq('demo phoenix')
      expect(project['team_id']).to eq(176_692)
    end

    it 'should support pagination' do
      projects = VCR.use_cassette('all_projects_pagination') do
        test_client.projects limit: 1, page: 2
      end
      project = projects.content['projects'][0]

      expect(projects.content.count).to eq(1)
      expect(projects.total_results).to eq(5)
      expect(projects.total_pages).to eq(5)
      expect(projects.results_per_page).to eq(1)
      expect(projects.current_page).to eq(2)

      expect(project['name']).to eq('demo phoenix copy')
      expect(project['created_by']).to eq(20_181)
      expect(project['statistics']['progress']).to eq(0)
    end
  end

  describe '#project' do
    it 'should return a single project' do
      project = VCR.use_cassette('project') do
        test_client.project '803826145ba90b42d5d860.46800099'
      end.content

      expect(project['project_id']).to eq('803826145ba90b42d5d860.46800099')
      expect(project['name']).to eq('demo phoenix')
      expect(project['team_id']).to eq(176_692)
    end
  end
end
