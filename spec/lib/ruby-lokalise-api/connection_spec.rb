# frozen_string_literal: true

RSpec.describe Lokalise::Connection do
  include described_class

  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:key_id) { 44_596_059 }

  before { Lokalise.reset_client! }

  after do
    Lokalise.reset_client!
    Faraday.default_adapter = :net_http
  end

  it 'Authorization header must be present for OAuth client' do
    conn = connection test_oauth_client
    expect(conn.headers['Authorization']).to eq("Bearer #{test_client.token}")
    expect(conn.headers['X-api-token']).to be_nil
  end

  it 'timeouts and compression should not be set by default but the token must be present' do
    conn = connection test_client
    expect(conn.options.timeout).to be_nil
    expect(conn.options.open_timeout).to be_nil
    expect(conn.headers['X-api-token']).to eq(test_client.token)
    expect(conn.builder.handlers).not_to include(FaradayMiddleware::Gzip)
  end

  it 'allows to customize timeouts' do
    custom_client = Lokalise.client(ENV['LOKALISE_API_TOKEN'],
                                    open_timeout: 100, timeout: 500)
    conn = connection custom_client
    expect(conn.options.timeout).to eq(500)
    expect(conn.options.open_timeout).to eq(100)
    expect(conn.headers['X-api-token']).to eq(custom_client.token)

    custom_client.timeout = 300
    custom_client.open_timeout = 200
    another_conn = connection custom_client
    expect(another_conn.options.timeout).to eq(300)
    expect(another_conn.options.open_timeout).to eq(200)
  end

  it 'is possible to customize adapter' do
    conn = connection test_client
    expect(conn.builder.adapter).to eq(Faraday::Adapter::NetHttp)

    Faraday.default_adapter = :excon

    another_conn = connection test_client
    expect(another_conn.builder.adapter).to eq(Faraday::Adapter::Excon)
    expect(conn.builder.adapter).to eq(Faraday::Adapter::NetHttp)
  end

  it 'allows to customize compression' do
    custom_client = Lokalise.client(ENV['LOKALISE_API_TOKEN'], enable_compression: true)
    conn = connection custom_client
    expect(conn.headers['X-api-token']).to eq(custom_client.token)
    expect(conn.builder.handlers).to include(FaradayMiddleware::Gzip)
  end

  it 'is possible to enable gzip compression' do
    gzip_client = Lokalise.client(ENV['LOKALISE_API_TOKEN'], enable_compression: true)
    keys = VCR.use_cassette('all_keys_gzip') do
      gzip_client.keys project_id
    end.collection

    expect(keys.first.key_id).to eq(key_id)
  end

  it 'is possible to disable gzip compression' do
    no_gzip_client = Lokalise.client(ENV['LOKALISE_API_TOKEN'], enable_compression: false)
    keys = VCR.use_cassette('all_keys_no_gzip') do
      no_gzip_client.keys project_id
    end.collection

    expect(keys.first.key_id).to eq(key_id)
  end

  it 'gzip compression is off by default' do
    default_gzip_client = Lokalise.client(ENV['LOKALISE_API_TOKEN'])
    keys = VCR.use_cassette('all_keys_default_gzip') do
      default_gzip_client.keys project_id
    end.collection

    expect(keys.first.key_id).to eq(key_id)
  end
end
