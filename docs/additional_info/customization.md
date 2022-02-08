# Customization

## Setting Timeouts

Request timeouts may be adjusted during client initialization:

```ruby
# The same approach will work with the `.oauth2_client` method:

@client = Lokalise.client('YOUR_TOKEN', open_timeout: 100, timeout: 500)
@client.open_timeout # => 100
@client.timeout # => 500
```

Both values are in *seconds*. They can be adjusted later with simple accessors:

```ruby
@client.open_timeout = 200
@client.timeout = 600
@client.open_timeout # => 200
@client.timeout # => 600
```

## Customizing JSON parser

By default we are using a [built-in JSON module](https://ruby-doc.org/stdlib-2.0.0/libdoc/json/rdoc/JSON.html) but you may utilize any other parser by overriding the `#custom_dump` and `#custom_load` methods inside the `Lokalise::JsonHandler` module.

For example, to use [Oj](https://github.com/ohler55/oj) you would do the following:

```ruby
require 'oj'

module Lokalise
  module JsonHandler
    # This method accepts a Ruby object and must return a JSON string
    def custom_dump(obj)
      Oj.dump obj
    end

    # This method accepts JSON and must return Ruby object
    def custom_load(obj)
      Oj.load obj
    end
  end
end
```

## Choosing Network Adapter

This library utilizes [Faraday](https://lostisland.github.io/faraday) to perform requests. The default adapter is built-in [Net::HTTP](https://ruby-doc.org/stdlib-2.6.3/libdoc/net/http/rdoc/Net/HTTP.html) but you may customize it as needed.

For example, to use [Excon](https://github.com/excon/excon):

```ruby
require 'excon' # somewhere in your code
Faraday.default_adapter = :excon
```

Please note that since the release of Faraday 2, most adapters have to be added manually. Find all supported adapters [on Faraday official website](https://github.com/lostisland/awesome-faraday#adapters).
