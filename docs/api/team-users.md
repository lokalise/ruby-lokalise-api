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
team_id = '1234'
params = {
  limit: 1,
  page: 3
}

users = @client.team_users team_id, params

users[0].user_id # => 5678
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

For example:

```ruby
team_id = '1234'
user_id = '6789'

user = @client.team_user team_id, user_id

user.fullname # => 'John Doe'
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

For example:

```ruby
params = {
  role: 'admin'
}

user = @client.update_team_user team_id, team_user_id, params

user.role # => 'admin'
```

Alternatively:

```ruby
user = @client.team_user team_id, user_id
user.update params
```

## Delete team user

[Doc](https://developers.lokalise.com/reference/delete-a-team-user)

```ruby
@client.destroy_team_user(team_id, user_id) # Input:
                                            ## team_id (string, required)
                                            ## user_id (string, required)
                                            # Output:
                                            ## Generic with "team_id" and "team_user_deleted" set to "true"
```

For example:

```ruby
response = @client.destroy_team_user team_id, user_id
response.team_user_deleted # => true
```

Alternatively:

```ruby
user = @client.team_user team_id, user_id
response = user.destroy
```