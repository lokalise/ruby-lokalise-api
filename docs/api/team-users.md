# Team users

## Fetch team users

[Doc](https://developers.lokalise.com/reference/list-all-team-users)

```ruby
@client.team_users(team_id, params = {})  # Input:
                                          ## team_id (string, required)
                                          ## params (hash)
                                          ### :page and :limit
                                          # Output:
                                          ## Collection of team users
```

For example:

```ruby
@client.team_users team_id, limit: 1, page: 3
```

## Fetch a single team user

[Doc](https://developers.lokalise.com/reference/retrieve-a-team-user)

```ruby
@client.team_user(team_id, user_id) # Input:
                                    ## team_id (string, required)
                                    ## user_id (string, required)
                                    # Output:
                                    ## Team user
```

## Update team user

[Doc](https://developers.lokalise.com/reference/update-a-team-user)

```ruby
@client.update_team_user(team_id, user_id, params)  # Input:
                                                    ## team_id (string, required)
                                                    ## user_id (string, required)
                                                    ## params (hash, required):
                                                    ### :role (string, required) - :owner, :admin, or :member
                                                    # Output:
                                                    ## Updated team user
```

Alternatively:

```ruby
user = @client.team_user('team_id', 'user_id')
user.update(params)
```

For example:

```ruby
@client.update_team_user team_id, team_user_id, role: 'admin'
```

## Delete team user

[Doc](https://developers.lokalise.com/reference/delete-a-team-user)

```ruby
@client.destroy_team_user(team_id, user_id) # Input:
                                            ## team_id (string, required)
                                            ## user_id (string, required)
                                            # Output:
                                            ## Hash with "team_id" and "team_user_deleted" set to "true"
```

Alternatively:

```ruby
user = @client.team_user('team_id', 'user_id')
user.destroy
```
