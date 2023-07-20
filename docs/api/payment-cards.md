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
cards = @client.payment_cards limit: 3, page: 1

cards[0].last4 # => '1234'
```

## Fetch a single payment card

[Doc](https://developers.lokalise.com/reference/retrieve-a-card)

```ruby
@client.payment_card(card_id)     # Input:
                                  ## card_id (string, required)
                                  # Output:
                                  ## A single payment card
```

For example:

```ruby
card_id = '6789'

card = @client.payment_card card_id

card.last4 # => '1234'
card.brand # => 'Visa'
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
params = {
  number: '4242424242424242',
  cvc: '123',
  exp_month: '12',
  exp_year: '2020'
}

card = @client.create_payment_card params

card.last4 # => '4242'
card.brand # => 'Visa'
```

## Delete a payment card

[Doc](https://developers.lokalise.com/reference/delete-a-card)

```ruby
@client.destroy_payment_card(card_id)   # Input:
                                        ## card_id (integer, string, required)
                                        # Output:
                                        ## Generic containing card id and `card_deleted => true` attribute
```

For example:

```ruby
response = @client.destroy_payment_card card_id
response.card_deleted # => true
```

Alternatively:

```ruby
card = @client.payment_card card_id
response = card.destroy
```