---
---
# Translation providers

## Fetch translation providers

[Doc](https://developers.lokalise.com/reference/list-all-providers)

```ruby
@client.translation_providers(team_id, params = {})   # Input:
                                                      ## team_id (string, required)
                                                      ## params (hash)
                                                      ### :page and :limit
                                                      # Output:
                                                      ## Collection of providers for the team
```

For example:

```ruby
team_id = '1234'
params = {
  limit: 2,
  page: 1
}

providers = @client.translation_providers team_id, params

providers[0].name # => 'Gengo'
```

## Fetch a single translation provider

[Doc](https://developers.lokalise.com/reference/retrieve-a-provider)

```ruby
@client.translation_provider(team_id, provider_id)  # Input:
                                                    ## team_id (string, required)
                                                    ## provider_id (string, required)
                                                    # Output:
                                                    ## Single provider for the team
```

For example:

```ruby
provider = @client.translation_provider team_id, provider_id

provider.slug # => 'gengo'
provider.pairs[0]['price_per_word'] # => 0.069
```