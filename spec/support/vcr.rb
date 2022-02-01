# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.ignore_hosts 'codeclimate.com'
  c.hook_into :faraday
  c.cassette_library_dir = File.join(File.dirname(__FILE__), '..', 'fixtures', 'vcr_cassettes')
  c.filter_sensitive_data('<LOKALISE_TOKEN>') { ENV.fetch('LOKALISE_API_TOKEN') }
  c.filter_sensitive_data('<OAUTH2_CLIENT_ID>') { ENV.fetch('OAUTH2_CLIENT_ID') }
  c.filter_sensitive_data('<OAUTH2_CLIENT_SECRET>') { ENV.fetch('OAUTH2_CLIENT_SECRET') }
  c.filter_sensitive_data('<OAUTH2_TOKEN>') { ENV.fetch('OAUTH2_TOKEN') }
  c.filter_sensitive_data('<OAUTH2_CODE>') { ENV.fetch('OAUTH2_CODE') }
  c.filter_sensitive_data('<OAUTH2_REFRESH_TOKEN>') { ENV.fetch('OAUTH2_REFRESH_TOKEN') }
end
