# Payment cards

## Fetch payment cards

[Doc](https://developers.lokalise.com/reference/list-all-cards)

```ruby
@client.payment_cards(params = {})    # Input:
                                      ## params (hash)
                                      ### :page and :limit
                                      # Output:
                                      ## Collection of payment cards under the `payment_cards` attribute
```

For example:

```ruby
@client.payment_cards limit: 1, page: 1
```

## Fetch a single payment card

[Doc](https://developers.lokalise.com/reference/retrieve-a-card)

```ruby
@client.payment_card(card_id)     # Input:
                                  ## card_id (string, required)
                                  # Output:
                                  ## A single payment card
```

## Create a payment card

[Doc](https://developers.lokalise.com/reference/create-a-card)

```ruby
@client.create_payment_card(params)   # Input:
                                      ## params (hash, required)
                                      ### number (integer, string, required) - card number
                                      ### cvc (integer, required) - 3-digit card CVV (CVC)
                                      ### exp_month (integer, required) - card expiration month (1 - 12)
                                      ### exp_year (integer, required) - card expiration year (for example, 2019)
                                      # Output:
                                      ## A newly created payment card

```

For example:

```ruby
@client.create_payment_card number: '4242424242424242',
                            cvc: '123',
                            exp_month: 1,
                            exp_year: 2030
```

## Delete a payment card

[Doc](https://developers.lokalise.com/reference/delete-a-card)

```ruby
@client.destroy_payment_card(card_id)   # Input:
                                        ## card_id (integer, string, required)
                                        # Output:
                                        ## Hash containing card id and `card_deleted => true` attribute
```

Alternatively:

```ruby
card = @client.payment_card('card_id')
card.destroy
```
