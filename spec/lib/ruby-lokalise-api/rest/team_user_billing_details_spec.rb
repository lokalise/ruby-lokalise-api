# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:team_id) { 176_692 }
  let(:team_id2) { 273_879 }

  specify '#team_user_billing_details' do
    details = VCR.use_cassette('team_user_billing_details') do
      test_client.team_user_billing_details team_id
    end

    expect(details.billing_email).to eq('hello@example.com')
    expect(details.country_code).to eq('LV')
    expect(details.zip).to eq('LV-6543')
    expect(details.state_code).to eq('')
    expect(details.address1).to eq('Sample line 1')
    expect(details.address2).to eq('Sample line 2')
    expect(details.city).to eq('Riga')
    expect(details.phone).to eq('+371123456')
    expect(details.company).to eq('Self-employed')
    expect(details.vatnumber).to eq('123')
  end

  specify '#create_team_user_billing_details' do
    details = VCR.use_cassette('create_team_user_billing_details') do
      test_client.create_team_user_billing_details team_id2, billing_email: 'ruby@example.com',
                                                             country_code: 'LV',
                                                             zip: 'LV-1111'
    end

    expect(details.billing_email).to eq('ruby@example.com')
    expect(details.country_code).to eq('LV')
    expect(details.address1).to eq('')
  end

  specify '#update_team_user_billing_details' do
    details = VCR.use_cassette('update_team_user_billing_details') do
      test_client.update_team_user_billing_details team_id2, billing_email: 'ruby_rspec@example.com',
                                                             country_code: 'LV',
                                                             zip: 'LV-1111',
                                                             address1: 'Addr line 1'
    end

    expect(details.billing_email).to eq('ruby_rspec@example.com')
    expect(details.country_code).to eq('LV')
    expect(details.address1).to eq('Addr line 1')
  end
end
