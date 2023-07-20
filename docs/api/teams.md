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