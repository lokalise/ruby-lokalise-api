# Lokalise API v2 official Ruby interface

![Gem](https://img.shields.io/gem/v/ruby-lokalise-api)
![CI](https://github.com/lokalise/ruby-lokalise-api/actions/workflows/ci.yml/badge.svg)
[![Test Coverage](https://codecov.io/gh/lokalise/ruby-lokalise-api/graph/badge.svg)](https://codecov.io/gh/lokalise/ruby-lokalise-api)
![Downloads total](https://img.shields.io/gem/dt/ruby-lokalise-api)

Official opinionated Ruby interface for the [Lokalise API](https://app.lokalise.com/api2docs/curl/) that represents returned data as Ruby objects.

Looking for a Rails integration? Try the [lokalise_rails gem](https://github.com/bodrovis/lokalise_rails). Also you can use a [lokalise_manager gem](https://github.com/bodrovis/lokalise_manager) which allows to exchange translation files between Lokalise and *any* Ruby script.

## Quickstart

Install the gem by running:

```bash
$ gem install ruby-lokalise-api
```

Obtain an API token in your [personal profile](https://lokalise.com/profile#apitokens) (*API tokens* section) and initialize the client:

```ruby
require 'ruby_lokalise_api'

@client = RubyLokaliseApi.client 'YOUR_TOKEN_HERE'
```

Now the `@client` can be used to perform API requests:

```ruby
project = @client.project '123.abc'
project.name

process = @client.upload_file project_id,
                              data: 'Base-64 encoded data... ZnI6DQogI...',
                              filename: 'my_file.yml',
                              lang_iso: 'en'

process.status
```

Alternatively instantiate your client with an [OAuth2 token](http://docs.lokalise.com/en/articles/5574713-oauth-2):

```ruby
@client = RubyLokaliseApi.oauth2_client 'YOUR_OAUTH2_TOKEN_HERE'
```

Learn how to generate an OAuth2 token [in the docs](https://lokalise.github.io/ruby-lokalise-api/additional_info/oauth2).

## Usage

Detailed documentation can be found at [lokalise.github.io/ruby-lokalise-api](https://lokalise.github.io/ruby-lokalise-api/).

You can also check [this repo containing some usage examples](https://github.com/bodrovis-learning/Lokalise-APIv2-Samples) and [this blog post with explanations](https://lokalise.com/blog/lokalise-apiv2-in-practice).

## License

This gem is licensed under the [BSD 3 Clause license](https://github.com/lokalise/ruby-lokalise-api/blob/master/LICENSE). Prior to version 4 the license type was MIT.

Copyright (c) [Lokalise team](http://lokalise.co) and [Ilya Bodrov](http://bodrovis.tech)
