# Lokalise API v2 official Ruby interface

![Gem](https://img.shields.io/gem/v/ruby-lokalise-api)
[![Build Status](https://travis-ci.com/lokalise/ruby-lokalise-api.svg?branch=master)](https://travis-ci.com/github/lokalise/ruby-lokalise-api)
[![Test Coverage](https://codecov.io/gh/lokalise/ruby-lokalise-api/graph/badge.svg)](https://codecov.io/gh/lokalise/ruby-lokalise-api)
![Downloads total](https://img.shields.io/gem/dt/ruby-lokalise-api)

Official opinionated Ruby interface for the [Lokalise API](https://app.lokalise.com/api2docs/curl/) that represents returned data as Ruby objects.

Looking for a Rails integration? Try the new [lokalise_rails gem](https://github.com/bodrovis/lokalise_rails).

## Quickstart

Install the gem by running:

```bash
$ gem install ruby-lokalise-api
```

Obtain an API token in your [personal profile](https://lokalise.com/profile#apitokens) (*API tokens* section) and initialize the client:

```ruby
require 'ruby-lokalise-api'

@client = Lokalise.client 'YOUR_TOKEN_HERE'
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

## Usage

Detailed documentation can be found at [lokalise.github.io/ruby-lokalise-api](https://lokalise.github.io/ruby-lokalise-api/).

## License

This gem is licensed under the [BSD 3 Clause license](https://github.com/lokalise/ruby-lokalise-api/blob/master/LICENSE). Prior to version 4 the license type was MIT.

Copyright (c) [Lokalise team](http://lokalise.co), [Ilya Bodrov](http://bodrovis.tech)
