# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::CustomTranslationStatuses do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:status_id) { 14_462 }

  specify '#custom_translation_status' do
    stub(
      uri: "projects/#{project_id}/custom_translation_statuses/#{status_id}",
      resp: { body: fixture('cts/status') }
    )

    status = test_client.custom_translation_status project_id, status_id

    expect(status.project_id).to eq(project_id)
    expect(status.branch).to eq('master')
    expect(status.status_id).to eq(status_id)
    expect(status.title).to eq('approved')
    expect(status.color).to eq('#0079bf')
  end

  specify '#custom_translation_statuses' do
    stub(
      uri: "projects/#{project_id}/custom_translation_statuses",
      resp: {
        body: fixture('cts/statuses'),
        headers: {
          'x-pagination-total-count': '3',
          'x-pagination-page-count': '1',
          'x-pagination-limit': '100',
          'x-pagination-page': '1'
        }
      }
    )

    statuses = test_client.custom_translation_statuses project_id

    expect(statuses.project_id).to eq(project_id)
    expect(statuses.branch).to eq('master')
    expect(statuses).to be_an_instance_of(RubyLokaliseApi::Collections::CustomTranslationStatuses)
    expect(statuses.total_results).to eq(3)
    expect_to_have_valid_resources(statuses)
  end

  specify '#create_custom_translation_status' do
    data = {
      title: 'ruby',
      color: '#ff9f1a'
    }

    stub(
      uri: "projects/#{project_id}/custom_translation_statuses",
      req: { body: data, verb: :post },
      resp: { body: fixture('cts/create_status') }
    )

    status = test_client.create_custom_translation_status project_id, data

    expect(status.project_id).to eq(project_id)
    expect(status.title).to eq(data[:title])
  end

  specify '#update_custom_translation_status' do
    data = {
      title: 'ruby2'
    }
    update_status_id = 14_465

    stub(
      uri: "projects/#{project_id}/custom_translation_statuses/#{update_status_id}",
      req: { body: data, verb: :put },
      resp: { body: fixture('cts/update_status') }
    )

    status = test_client.update_custom_translation_status project_id, update_status_id, data

    expect(status.status_id).to eq(update_status_id)
    expect(status.title).to eq(data[:title])
  end

  specify '#destroy_custom_translation_status' do
    destroy_status_id = 14_465

    stub(
      uri: "projects/#{project_id}/custom_translation_statuses/#{destroy_status_id}",
      req: { verb: :delete },
      resp: { body: fixture('cts/destroy_status') }
    )

    res = test_client.destroy_custom_translation_status project_id, destroy_status_id

    expect(res.project_id).to eq(project_id)
    expect(res.branch).to eq('master')
    expect(res.custom_translation_status_deleted).to be true
  end

  specify '#custom_translation_status_colors' do
    stub(
      uri: "projects/#{project_id}/custom_translation_statuses/colors",
      resp: { body: fixture('cts/colors') }
    )

    res = test_client.custom_translation_status_colors project_id

    expect(res).to be_an_instance_of(RubyLokaliseApi::Generics::CustomStatusAvailableColors)
    expect(res.colors).to include('#61bd4f')
  end
end
