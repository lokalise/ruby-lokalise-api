# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Connection do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }

  let(:dummy) { Class.new { include RubyLokaliseApi::Connection }.new }

  let(:project_endpoint) do
    endpoint name: 'Projects', client: test_client, params: { query: [project_id] }
  end

  before { RubyLokaliseApi.reset_client! }

  after do
    RubyLokaliseApi.reset_client!
    Faraday.default_adapter = :net_http
  end

  it 'timeouts are not be set by default but the token must be present' do
    conn = dummy.connection project_endpoint

    expect(conn.options.timeout).to be_nil
    expect(conn.options.open_timeout).to be_nil
    expect(conn.headers['X-api-token']).to eq(test_client.token)
  end

  it 'allows to customize timeouts' do
    custom_client = RubyLokaliseApi.client(ENV.fetch('LOKALISE_API_TOKEN', nil),
                                           open_timeout: 100, timeout: 500)

    custom_endpoint = endpoint name: 'Projects', client: custom_client, params: { query: [project_id] }

    conn = dummy.connection custom_endpoint

    expect(conn.options.timeout).to eq(500)
    expect(conn.options.open_timeout).to eq(100)
    expect(conn.headers['X-api-token']).to eq(custom_client.token)

    custom_client.timeout = 300
    custom_client.open_timeout = 200

    another_conn = dummy.connection custom_endpoint

    expect(another_conn.options.timeout).to eq(300)
    expect(another_conn.options.open_timeout).to eq(200)
  end

  it 'gzip compression is on by default' do
    custom_client = RubyLokaliseApi.client(ENV.fetch('LOKALISE_API_TOKEN', nil))

    conn = dummy.connection project_endpoint

    expect(conn.headers['X-api-token']).to eq(custom_client.token)
    expect(conn.builder.handlers).to include(Faraday::Gzip::Middleware)
  end

  it 'is possible to customize adapter' do
    conn = dummy.connection project_endpoint

    expect(conn.builder.adapter).to eq(Faraday::Adapter::NetHttp)

    Faraday.default_adapter = :test

    another_conn = dummy.connection project_endpoint

    expect(another_conn.builder.adapter).to eq(Faraday::Adapter::Test)
    expect(conn.builder.adapter).to eq(Faraday::Adapter::NetHttp)
  end
end
