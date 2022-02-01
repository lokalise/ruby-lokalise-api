# frozen_string_literal: true

RSpec.describe Lokalise::Connection do
  let(:dummy) { Class.new { include Lokalise::Connection }.new }

  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:key_id) { 44_596_059 }

  before { Lokalise.reset_client! }

  after { Lokalise.reset_client! }

  it 'Authorization header must be present for OAuth client' do
    conn = dummy.connection test_oauth_client
    expect(conn.headers['Authorization']).to eq("Bearer #{test_client.token}")
    expect(conn.headers['X-api-token']).to be_nil
  end

  it 'timeouts are not be set by default but the token must be present' do
    conn = dummy.connection test_client
    expect(conn.options.timeout).to be_nil
    expect(conn.options.open_timeout).to be_nil
    expect(conn.headers['X-api-token']).to eq(test_client.token)
  end

  it 'allows to customize timeouts' do
    custom_client = Lokalise.client(ENV['LOKALISE_API_TOKEN'],
                                    open_timeout: 100, timeout: 500)
    conn = dummy.connection custom_client
    expect(conn.options.timeout).to eq(500)
    expect(conn.options.open_timeout).to eq(100)
    expect(conn.headers['X-api-token']).to eq(custom_client.token)

    custom_client.timeout = 300
    custom_client.open_timeout = 200
    another_conn = dummy.connection custom_client
    expect(another_conn.options.timeout).to eq(300)
    expect(another_conn.options.open_timeout).to eq(200)
  end

  it 'is possible to enable gzip compression' do
    gzip_client = Lokalise.client(ENV['LOKALISE_API_TOKEN'])
    keys = VCR.use_cassette('all_keys_gzip') do
      gzip_client.keys project_id, limit: 30
    end.collection

    expect(keys.first.key_id).to eq(key_id)
  end

  it 'gzip compression is on by default' do
    custom_client = Lokalise.client(ENV['LOKALISE_API_TOKEN'])
    conn = dummy.connection custom_client
    expect(conn.headers['X-api-token']).to eq(custom_client.token)
    expect(conn.headers['Accept-Encoding']).to eq('gzip,deflate,br')
  end
end
