# frozen_string_literal: true

module RubyLokaliseApi
  class BaseClient
    attr_reader :token, :token_header
    attr_accessor :timeout, :open_timeout

    def initialize(token, params = {})
      @token = token
      @timeout = params.fetch(:timeout, nil)
      @open_timeout = params.fetch(:open_timeout, nil)
      @token_header = ''
    end
  end
end
