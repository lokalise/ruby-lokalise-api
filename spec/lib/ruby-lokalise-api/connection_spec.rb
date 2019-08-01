RSpec.describe Lokalise::Connection do
  include described_class

  before(:each) { Lokalise.reset_client! }
  after(:all) do
    Lokalise.reset_client!
    Faraday.default_adapter = :net_http
  end

  it 'timeouts should not be set by default but the token must be present' do
    conn = connection test_client
    expect(conn.options.timeout).to be_nil
    expect(conn.options.open_timeout).to be_nil
    expect(conn.headers['X-api-token']).to eq(test_client.token)
  end

  it 'should allow to customize timeouts' do
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

  it 'should be possible to customize adapter' do
    conn = connection test_client
    expect(conn.builder.handlers).to eq([Faraday::Adapter::NetHttp])

    Faraday.default_adapter = :excon

    another_conn = connection test_client
    expect(another_conn.builder.handlers).to eq([Faraday::Adapter::Excon])
  end
end
