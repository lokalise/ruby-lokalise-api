# frozen_string_literal: true

module Stubs
  def response(content, endpoint)
    RubyLokaliseApi::Response.new content, endpoint
  end

  def stub(uri:, req: {}, resp: {})
    base_url = req.fetch(:base_url, RubyLokaliseApi::Endpoints::MainEndpoint::BASE_URL)

    stub_request(
      req.fetch(:verb, :get),
      "#{base_url}/#{uri}"
    ).with(
      request_params(req)
    ).to_return(
      response_params(resp)
    )
  end

  def loaded_fixture(filename)
    Oj.load fixture(filename)
  end

  def fixture(filename)
    Fixtures::STUBS[filename]
  end

  private

  def response_params(resp)
    {
      status: resp.fetch(:code, 200),
      body: formatted_body(resp[:body]),
      headers: resp[:headers]
    }.compact
  end

  def formatted_body(body)
    return unless body

    body.is_a?(Hash) ? Oj.dump(body, mode: :strict) : body
  end

  def request_params(req)
    {
      headers: default_headers(req),
      body: formatted_body(req[:body]),
      query: req[:query]
    }.compact
  end

  def default_headers(req)
    headers = {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip,deflate,br',
      'User-Agent' => "ruby-lokalise-api gem/#{RubyLokaliseApi::VERSION}"
    }

    add_auth_header(headers, req)
  end

  def add_auth_header(headers, req)
    return headers if req[:skip_token]

    token_header = req.fetch(:token_header, 'X-Api-Token')
    token = req.fetch(:token) { ENV.fetch('LOKALISE_API_TOKEN', nil) }

    headers[token_header] = token
    headers
  end
end
