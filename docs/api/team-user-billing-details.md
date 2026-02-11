---
---
# Team user billing details

## Fetch team user billing details

[Doc](https://developers.lokalise.com/reference/retrieve-team-user-billing-details)

```ruby
@client.team_user_billing_details(team_id)  # Input:
                                            ## team_id (string or integer, required)
                                            # Output:
                                            ## Billing details resource
```

For example:

```ruby
team_id = '1234'

details = @client.team_user_billing_details team_id

details.company # => 'Lokalise'
details.address1 # => 'Address line 1'
```

## Create team user billing details

[Doc](https://developers.lokalise.com/reference/create-team-user-billing-details)

```ruby
@client.create_team_user_billing_details(team_id, params)   # Input:
                                                            ## team_id (string or integer, required)
                                                            ## params (hash, required):
                                                            ### :billing_email (string, required)
                                                            ### :country_code (string, required)
                                                            ### :zip (string, required)
                                                            ### :state_code (string)
                                                            ### :address1 (string)
                                                            ### :address2 (string)
                                                            ### :city (string)
                                                            ### :phone (string)
                                                            ### :company (string)
                                                            ### :vatnumber (string)
                                                            # Output:
                                                            ## Billing details resource
```

For example:

```ruby
team_id = '1234'

params = {
  billing_email: 'ruby@example.com',
  country_code: 'LV',
  zip: 'LV-1111'
}

details = @client.create_team_user_billing_details team_id, params

details.zip # => 'LV-1111'
```

## Update team user billing details

[Doc](https://developers.lokalise.com/reference/update-team-user-billing-details)

```ruby
@client.update_team_user_billing_details(team_id, params)   # Input:
                                                            ## team_id (string or integer, required)
                                                            ## params (hash, required):
                                                            ### :billing_email (string, required)
                                                            ### :country_code (string, required)
                                                            ### :zip (string, required)
                                                            ### :state_code (string)
                                                            ### :address1 (string)
                                                            ### :address2 (string)
                                                            ### :city (string)
                                                            ### :phone (string)
                                                            ### :company (string)
                                                            ### :vatnumber (string)
                                                            # Output:
                                                            ## Billing details resource
```

For example:

```ruby
params = {
  billing_email: 'ruby@example.com',
  country_code: 'LV',
  zip: 'LV-1111',
  address1: 'Addr line 1',
  city: 'Riga'
}

details = @client.update_team_user_billing_details team_id, params

details.billing_email # => 'ruby@example.com'
```