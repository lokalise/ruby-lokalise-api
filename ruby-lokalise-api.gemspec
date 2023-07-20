# frozen_string_literal: true

require File.expand_path('lib/ruby_lokalise_api/version', __dir__)

Gem::Specification.new do |spec|
  spec.name                  = 'ruby-lokalise-api'
  spec.version               = RubyLokaliseApi::VERSION
  spec.authors               = ['Ilya Krukowski']
  spec.email                 = ['golosizpru@gmail.com']
  spec.summary               = 'Ruby interface to the Lokalise API'
  spec.description           = 'Opinionated Ruby client for the Lokalise platform API allowing to work with translations, projects, users and other resources as with Ruby objects.'
  spec.homepage              = 'https://github.com/lokalise/ruby-lokalise-api'
  spec.license               = 'BSD-3-Clause'
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.7'

  spec.files = Dir['README.md', 'LICENSE',
                   'CHANGELOG.md', 'lib/**/*.rb', 'lib/ruby_lokalise_api/data/*.yml',
                   'ruby-lokalise-api.gemspec', '.github/*.md',
                   'Gemfile', 'Rakefile']
  spec.extra_rdoc_files = ['README.md']
  spec.require_paths    = ['lib']

  spec.add_dependency 'addressable',                     '~> 2.5'
  spec.add_dependency 'faraday',                         '~> 2.0'
  spec.add_dependency 'faraday-gzip',                    '>= 0.1', '< 2.0'
  spec.add_dependency 'json',                            '~> 2'
  spec.add_dependency 'zeitwerk',                        '~> 2.4'

  spec.add_development_dependency 'dotenv',              '~> 2.5'
  spec.add_development_dependency 'oj',                  '~> 3.10'
  spec.add_development_dependency 'rake',                '~> 13.0'
  spec.add_development_dependency 'rspec',               '~> 3.6'
  spec.add_development_dependency 'rubocop',             '~> 1.6'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5'
  spec.add_development_dependency 'rubocop-rake',        '~> 0.6'
  spec.add_development_dependency 'rubocop-rspec',       '~> 2.0'
  spec.add_development_dependency 'simplecov',           '~> 0.21'
  spec.add_development_dependency 'simplecov-lcov',      '~> 0.8'
  spec.add_development_dependency 'webmock',             '~> 3.14'
  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
