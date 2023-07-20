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
    params = {
      status: resp.fetch(:code, 200)
    }

    if resp[:body]
      params[:body] = resp[:body].is_a?(Hash) ? Oj.dump(resp[:body], mode: :strict) : resp[:body]
    end

    params[:headers] = resp[:headers] if resp[:headers]

    params
  end

  def request_params(req)
    params = { headers: {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip,deflate,br',
      'User-Agent' => "ruby-lokalise-api gem/#{RubyLokaliseApi::VERSION}"
    } }

    params = add_auth_header(params, req)

    # The default :object mode encode hashes in a way that's not properly
    # recognized by Webmock
    params[:body] = Oj.dump(req[:body], mode: :strict) if req[:body]

    params[:query] = req[:query] if req[:query]

    params
  end

  def add_auth_header(params, req)
    return params if req[:skip_token]

    token_header = req.fetch(:token_header, 'X-Api-Token')
    token = req.fetch(:token) { ENV.fetch('LOKALISE_API_TOKEN', nil) }

    params[:headers][token_header] = token

    params
  end
end
