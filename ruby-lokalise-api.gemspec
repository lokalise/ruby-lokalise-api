require File.expand_path('../lib/ruby-lokalise-api/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name                  = 'ruby-lokalise-api'
  spec.version               = Lokalise::VERSION
  spec.authors               = ['Ilya Bodrov', 'Roman Kutanov']
  spec.email                 = ['golosizpru@gmail.com', 'kutanov@gmail.com']
  spec.summary               = 'Ruby interface to the Lokalise API'
  spec.description           = 'Ruby client for the Lokalise platform API allowing to work with translations, projects, users and more'
  spec.homepage              = 'https://github.com/lokalise/ruby-lokalise-api'
  spec.license               = 'MIT'
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.4.0'

  spec.files            =  Dir["README.md", "LICENSE", "CONTRIBUTING.md",
                               "CHANGELOG.md", "lib/**/*.rb", "chgk_rating.gemspec",
                               "Gemfile", "Rakefile"]
  spec.test_files       = Dir["spec/**/*.rb"]
  spec.extra_rdoc_files = ['README.md']
  spec.require_paths    = ['lib']

  spec.add_dependency 'faraday',                       '~> 0.13'
  spec.add_dependency 'multi_json',                    '~> 1.12'

  spec.add_development_dependency 'rake',                      '~> 12.1'
  spec.add_development_dependency 'rspec',                     '~> 3.6'
  spec.add_development_dependency 'vcr',                       '~> 4.0'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
end