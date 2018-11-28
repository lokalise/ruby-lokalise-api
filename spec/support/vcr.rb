require 'vcr'

VCR.configure do |c|
  c.ignore_hosts 'codeclimate.com'
  c.hook_into :faraday
  c.cassette_library_dir = File.join(File.dirname(__FILE__), '..', 'fixtures', 'vcr_cassettes')
  c.filter_sensitive_data('<LOKALISE_TOKEN>') { ENV.fetch('LOKALISE_API_TOKEN') }
end
