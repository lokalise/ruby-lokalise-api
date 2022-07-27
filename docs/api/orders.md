# Translation orders

[Order attributes](https://app.lokalise.com/api2docs/curl/#object-orders)

## Fetch orders

[Doc](https://developers.lokalise.com/reference/list-all-orders)

```ruby
@client.orders(team_id, params = {})  # Input:
                                      ## team_id (integer, string, required)
                                      ## params (hash)
                                      ### :page and :limit
                                      # Output:
                                      ## Collection of orders for the given team
```

For example:

```ruby
@client.orders team_id, limit: 1, page: 1
```

## Fetch a single order

[Doc](https://developers.lokalise.com/reference/retrieve-an-order)

```ruby
@client.order(team_id, order_id)  # Input:
                                  ## team_id (string, integer, required)
                                  ## order_id (string, required)
                                  # Output:
                                  ## A single order
```

## Create an order

[Doc](https://developers.lokalise.com/reference/create-an-order)

```ruby
@client.create_order(team_id, params)  # Input:
                                       ## team_id (string, integer, required)
                                       ## params (hash, required)
                                       ### project_id (string, required)
                                       ### card_id (integer, string, required) - card to process payment
                                       ### briefing (string, required)
                                       ### source_language_iso (string, required)
                                       ### target_language_isos (array of strings, required)
                                       ### keys (array of integers, required) - keys to include in the order
                                       ### provider_slug (string, required)
                                       ### translation_tier (integer, required)
                                       ### dry_run (boolean) - return the response without actually placing an order. Useful for price estimation. Default is `false`
                                       ### translation_style (string) - only for gengo provider. Available values are `formal`, `informal`, `business`, `friendly`. Defaults to `friendly`.
                                       # Output:
                                       ## A newly created order

```

For example:

```ruby
@client.create_order team_id,
                     project_id: project_id,
                     card_id: payment_card_id,
                     briefing: 'Some briefing',
                     source_language_iso: 'en',
                     target_language_isos: [
                       'ru'
                     ],
                     keys: [
                       1234,
                       5678 
                     ],
                     provider_slug: 'gengo',
                     translation_tier: '1',
                     dry_run: true
```