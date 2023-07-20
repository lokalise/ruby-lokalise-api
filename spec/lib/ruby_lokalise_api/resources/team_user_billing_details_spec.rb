# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::TeamUserBillingDetails do
  let(:team_id) { 176_692 }

  specify '#reload_data' do
    stub(
      uri: "teams/#{team_id}/billing_details",
      resp: { body: fixture('team_user_billing_details/team_user_billing_details') }
    )

    details = test_client.team_user_billing_details team_id

    reloaded_details = details.reload_data

    expect(reloaded_details).to be_an_instance_of(described_class)
  end

  specify '#update' do
    stub(
      uri: "teams/#{team_id}/billing_details",
      resp: { body: fixture('team_user_billing_details/team_user_billing_details') }
    )

    details = test_client.team_user_billing_details team_id

    details_data = {
      billing_email: 'hi2@lokalise.com',
      country_code: 'LV',
      zip: 'LV-1234'
    }

    stub(
      uri: "teams/#{team_id}/billing_details",
      req: { body: details_data, verb: :put },
      resp: { body: fixture('team_user_billing_details/update_billing_details') }
    )

    updated_details = details.update details_data

    expect(updated_details.billing_email).to eq(details_data[:billing_email])
    expect(updated_details.team_id).to eq(team_id)
  end

  it 'does not support destroy' do
    stub(
      uri: "teams/#{team_id}/billing_details",
      resp: { body: fixture('team_user_billing_details/team_user_billing_details') }
    )

    details = test_client.team_user_billing_details team_id

    expect(details).not_to respond_to(:destroy)
  end
end
