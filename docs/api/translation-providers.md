# Translation providers

[Translation provider attributes](https://app.lokalise.com/api2docs/curl/#object-translation-providers)

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
@client.translation_providers team_id, limit: 1, page: 2
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
