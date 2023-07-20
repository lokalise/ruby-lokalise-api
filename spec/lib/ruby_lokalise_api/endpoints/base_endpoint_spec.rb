# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Endpoints::BaseEndpoint do
  subject { described_class.new test_client }

  let(:endpoint) { subject }

  it { is_expected.to respond_to(:do_get) }
  it { is_expected.to respond_to(:do_post) }
  it { is_expected.not_to respond_to(:very_wrong_method) }

  it 'raises an error when calling invalid methods' do
    expect { endpoint.very_wrong_method }.to raise_error(NoMethodError)
  end
end
