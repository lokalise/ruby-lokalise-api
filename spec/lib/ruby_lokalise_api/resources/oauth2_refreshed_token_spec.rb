# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::OAuth2RefreshedToken do
  subject do
    described_class.new response(nil, nil)
  end

  it { is_expected.not_to respond_to(:update) }
  it { is_expected.not_to respond_to(:destroy) }
  it { is_expected.not_to respond_to(:reload_data) }
end
