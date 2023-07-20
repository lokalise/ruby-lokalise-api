# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Contributors do
  let(:project_id) { '20603843642073fe124fb8.14291681' }
  let(:user_id) { 20_181 }

  specify '#contributor' do
    stub(
      uri: "projects/#{project_id}/contributors/#{user_id}",
      resp: { body: fixture('contributors/contributor') }
    )

    contributor = test_client.contributor project_id, user_id

    expect(contributor.project_id).to eq(project_id)
    expect(contributor.user_id).to eq(user_id)
    expect(contributor.email).to eq('bodrovis@protonmail.com')
    expect(contributor.fullname).to eq('Ilya B')
    expect(contributor.created_at).to eq('2018-08-21 15:35:25 (Etc/UTC)')
    expect(contributor.created_at_timestamp).to eq(1_534_865_725)
    expect(contributor.is_admin).to be true
    expect(contributor.is_reviewer).to be true
    expect(contributor.languages).to include(
      'lang_id' => 10_001,
      'lang_iso' => 'custom_1',
      'lang_name' => 'Quenya',
      'is_writable' => true
    )
    expect(contributor.admin_rights).to include('upload')
  end

  specify '#contributors' do
    stub(
      uri: "projects/#{project_id}/contributors",
      resp: { body: fixture('contributors/contributors') }
    )

    contributors = test_client.contributors project_id

    expect(contributors.collection.length).to eq(3)
    expect_to_have_valid_resources(contributors)
    expect(contributors.project_id).to eq(project_id)
    expect(contributors.branch).to eq('master')

    contributor = contributors[0]

    expect(contributor.user_id).to eq(20_181)
    expect(contributor.project_id).to eq(project_id)
  end

  specify '#create_contributors' do
    contributor_data = {
      email: 'ruby@contributor.sample',
      fullname: 'Ruby Contributor',
      is_admin: true
    }

    stub(
      uri: "projects/#{project_id}/contributors",
      req: { body: { contributors: [contributor_data] }, verb: :post },
      resp: { body: fixture('contributors/create_contributor') }
    )

    contributors = test_client.create_contributors project_id, contributor_data

    expect(contributors).to be_an_instance_of(RubyLokaliseApi::Collections::Contributors)
    expect_to_have_valid_resources(contributors)

    contributor = contributors[0]

    expect(contributor.project_id).to eq(project_id)
    expect(contributor.fullname).to eq(contributor_data[:fullname])
  end

  specify '#update_contributor' do
    update_contributor_id = 269_338

    contributor_data = {
      is_reviewer: true
    }

    stub(
      uri: "projects/#{project_id}/contributors/#{update_contributor_id}",
      req: { body: contributor_data, verb: :put },
      resp: { body: fixture('contributors/update_contributor') }
    )

    contributor = test_client.update_contributor project_id, update_contributor_id, contributor_data

    expect(contributor).to be_an_instance_of(RubyLokaliseApi::Resources::Contributor)
    expect(contributor.user_id).to eq(update_contributor_id)
    expect(contributor.is_reviewer).to be true
  end

  specify '#destroy_contributor' do
    contributor_to_delete = 269_338

    stub(
      uri: "projects/#{project_id}/contributors/#{contributor_to_delete}",
      req: { verb: :delete },
      resp: { body: fixture('contributors/destroy_contributor') }
    )

    resp = test_client.destroy_contributor(project_id, contributor_to_delete)

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.contributor_deleted).to be true
  end
end
