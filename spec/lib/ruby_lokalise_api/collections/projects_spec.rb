# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Projects do
  let(:projects) do
    collection 'Projects',
               response(loaded_fixture('projects/projects'), endpoint(name: 'Projects', client: test_client))
  end

  let(:pagination_headers) do
    {
      'x-pagination-total-count': '55',
      'x-pagination-page-count': '28',
      'x-pagination-limit': '2',
      'x-pagination-page': '1'
    }
  end

  let(:pagination_params) do
    { page: 1, limit: 2, include_statistics: 1 }
  end

  let(:projects_page_one) do
    stub(
      uri: 'projects',
      req: { query: pagination_params },
      resp: {
        body: fixture('projects/projects'),
        headers: pagination_headers
      }
    )

    test_client.projects pagination_params
  end

  let(:projects_page_two) do
    stub(
      uri: 'projects',
      req: { query: pagination_params.merge(page: 2) },
      resp: {
        body: fixture('projects/projects_next_page'),
        headers: pagination_headers.merge('x-pagination-page': '2')
      }
    )

    test_client.projects pagination_params.merge(page: 2)
  end

  it 'allows to perform chaining on projects' do
    project = projects.collection.first
    project_id = project.project_id

    params = { name: 'Android i18n', description: 'chain updated' }

    stub(
      uri: "projects/#{project_id}",
      req: { body: params, verb: :put },
      resp: { body: fixture('projects/update_project2') }
    )

    updated_project = project.update params

    expect(updated_project).to be_an_instance_of(RubyLokaliseApi::Resources::Project)
    expect(updated_project.description).to eq('chain updated')
  end

  specify '#next_page' do
    stub(
      uri: 'projects',
      req: { query: pagination_params.merge(page: 2) },
      resp: {
        body: fixture('projects/projects_next_page'),
        headers: pagination_headers.merge('x-pagination-page': '2')
      }
    )

    next_page_projects = projects_page_one.next_page

    expect(next_page_projects).to be_an_instance_of described_class
    expect_to_have_valid_resources(next_page_projects)
    expect(next_page_projects[0].name).to eq('API')

    expect(next_page_projects.prev_page?).to be true
    expect(next_page_projects.first_page?).to be false
    expect(next_page_projects.last_page?).to be false
    expect(next_page_projects.current_page).to eq(2)
    expect(next_page_projects.results_per_page).to eq(2)
    expect(next_page_projects.total_pages).to eq(28)
    expect(next_page_projects.total_results).to eq(55)
  end

  specify '#prev_page' do
    stub(
      uri: 'projects',
      req: { query: pagination_params },
      resp: {
        body: fixture('projects/projects'),
        headers: pagination_headers
      }
    )

    prev_page_projects = projects_page_two.prev_page

    expect(projects_page_two.prev_page?).to be true

    expect(prev_page_projects).to be_an_instance_of described_class
    expect(prev_page_projects[0].name).to eq('Android i18n')

    expect(prev_page_projects.prev_page?).to be false
    expect(prev_page_projects.first_page?).to be true
    expect(prev_page_projects.last_page?).to be false
    expect(prev_page_projects.current_page).to eq(1)
    expect(prev_page_projects.results_per_page).to eq(2)
    expect(prev_page_projects.total_pages).to eq(28)
    expect(prev_page_projects.total_results).to eq(55)
  end
end
