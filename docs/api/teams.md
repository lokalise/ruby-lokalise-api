---
---
# Teams

## Fetch teams

[Doc](https://developers.lokalise.com/reference/list-all-teams)

```ruby
@client.teams(params = {})  # Input:
                            ## params (hash)
                            ### :page and :limit
                            # Output:
                            ## Collection of teams
```

For example:

```ruby
params = {
  page: 3,
  limit: 2
}

teams = @client.teams params

teams[0].plan # => 'Trial'
```

## Fetch a single team

[Doc](https://developers.lokalise.com/reference/get-team-details)

```ruby
@client.team(team_id) # Input:
                      ## team_id (String or Integer)
                      # Output:
                      ## Team resource
```

For example:

```ruby
team_id = 12345
team = @client.team team_id

team.name # => "My Team"
```