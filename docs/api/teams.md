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
@client.teams page: 2, limit: 1
```