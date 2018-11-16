# RubyLokaliseApi Client

Official Ruby interface for the [Lokalise API](https://lokalise.co/api2docs/ruby/).

## Installation and Requirements

This gem requires Ruby 2.4+ and RubyGems.

Install it by running:

```bash
$ gem install ruby-lokalise-api
```

## Initializing the Client

In order to perform any API requests, you require a special token that can be obtained in your [personal profile](https://lokalise.co/profile#apitokens) (*API tokens* section). Note that the owner of the token must have admin access rights.

After you've obtained the token, initialize the client:

```ruby
require 'ruby-lokalise-api'

@client = Lokalise.client 'YOUR_TOKEN_HERE'
```

Now the `@client` can be used to perform API requests!

## API Rate Limits

Lokalise does not [rate-limit API requests](https://lokalise.co/api2docs/ruby/#resource-rate-limits), however retain a right to decline the service in case of excessive use. Only one concurrent request per token is allowed. To ensure data consistency, it is not recommended to access the same project simultaneously using multiple tokens.

## Running Tests

1. Copypaste `.env.example` file as `.env`.
2. Put your API token inside. The `.env` file is excluded from version control so your token is safe.
3. Run `rspec .`. Observe test results and code coverage.

## License

This plugin is licensed under the MIT License.

Copyright (c) [Lokalise team](http://lokalise.co), [Ilya Bodrov](http://bodrovis.tech), Roman Kutanov