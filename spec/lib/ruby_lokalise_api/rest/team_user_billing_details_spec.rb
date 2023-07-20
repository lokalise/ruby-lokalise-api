# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::TeamUserBillingDetails do
  let(:team_id) { 176_692 }

  specify '#team_user_billing_details' do
    stub(
      uri: "teams/#{team_id}/billing_details",
      resp: { body: fixture('team_user_billing_details/team_user_billing_details') }
    )

    details = test_client.team_user_billing_details team_id

    expect(details).to be_an_instance_of(RubyLokaliseApi::Resources::TeamUserBillingDetails)
    expect(details.team_id).to eq(team_id)
    expect(details.company).to eq('')
    expect(details.address1).to eq('Sample line 1')
    expect(details.address2).to eq('')
    expect(details.city).to eq('Riga')
    expect(details.zip).to eq('LV-6543')
    expect(details.phone).to eq('+371123456')
    expect(details.vatnumber).to eq('')
    expect(details.country_code).to eq('LV')
    expect(details.billing_email).to eq('hello@example.com')
    expect(details.state_code).to eq('')
  end

  specify '#create_team_user_billing_details' do
    another_team_id = 387_836

    details_data = {
      billing_email: 'hello@lokalise.com',
      country_code: 'LV',
      zip: 'LV-1234'
    }

    stub(
      uri: "teams/#{another_team_id}/billing_details",
      req: { body: details_data, verb: :post },
      resp: { body: fixture('team_user_billing_details/create_billing_details') }
    )

    details = test_client.create_team_user_billing_details another_team_id, details_data

    expect(details.zip).to eq(details_data[:zip])
    expect(details.team_id).to eq(another_team_id)
  end

  specify '#update_team_user_billing_details' do
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

    details = test_client.update_team_user_billing_details team_id, details_data

    expect(details.billing_email).to eq(details_data[:billing_email])
    expect(details.team_id).to eq(team_id)
  end
end
