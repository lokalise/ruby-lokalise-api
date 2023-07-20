# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Contributor do
  let(:loaded_contributor_fixture) { loaded_fixture('contributors/contributor2') }

  let(:project_id) { loaded_contributor_fixture['project_id'] }

  let(:contributor_endpoint) do
    params = { query: [project_id, loaded_contributor_fixture['contributor']['user_id']] }
    endpoint name: 'Contributors', client: test_client, params: params
  end

  let(:contributor) do
    resource 'Contributor', response(loaded_contributor_fixture, contributor_endpoint)
  end

  let(:contributor_id) { contributor.user_id }

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/contributors/#{contributor_id}",
      resp: { body: fixture('contributors/contributor2') }
    )

    reloaded_contributor = contributor.reload_data

    expect(reloaded_contributor.user_id).to eq(contributor_id)
    expect(reloaded_contributor.project_id).to eq(project_id)
  end

  specify '#update' do
    contributor_data = {
      is_reviewer: true
    }

    stub(
      uri: "projects/#{project_id}/contributors/#{contributor_id}",
      req: { body: contributor_data, verb: :put },
      resp: { body: fixture('contributors/update_contributor') }
    )

    updated_contributor = contributor.update contributor_data

    expect(updated_contributor).to be_an_instance_of(described_class)
    expect(updated_contributor.user_id).to eq(contributor_id)
    expect(updated_contributor.is_reviewer).to be true
  end

  specify '#destroy' do
    stub(
      uri: "projects/#{project_id}/contributors/#{contributor_id}",
      req: { verb: :delete },
      resp: { body: fixture('contributors/destroy_contributor') }
    )

    resp = contributor.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.contributor_deleted).to be true
  end
end
