# Team user billing details

[Team user billing details attributes](https://app.lokalise.com/api2docs/curl/#object-team-user-billing-details)

## Fetch team user billing details

[Doc](https://app.lokalise.com/api2docs/curl/#transition-retrieve-team-user-billing-details-get)

```ruby
@client.team_user_billing_details(team_id)  # Input:
                                            ## team_id (string or integer, required)
                                            # Output:
                                            ## Billing details resource
```

For example:

```ruby
@client.team_user_billing_details '1234'
```

## Create team user billing details

[Doc](https://app.lokalise.com/api2docs/curl/#transition-create-team-user-billing-details-post)

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
@client.create_team_user_billing_details 12345, billing_email: 'ruby@example.com',
                                                country_code: 'LV',
                                                zip: 'LV-1111'
```

## Update team user billing details

[Doc](https://app.lokalise.com/api2docs/curl/#transition-update-team-user-billing-details-put)

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
@client.update_team_user_billing_details 12345, billing_email: 'ruby_rspec@example.com',
                                                country_code: 'LV',
                                                zip: 'LV-1111',
                                                address1: 'Addr line 1',
                                                city: 'Riga'
```