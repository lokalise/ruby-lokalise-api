# JWT

## Get OTA JWT

[Doc](https://developers.lokalise.com/reference/create-service-jwt)

```ruby
@client.jwt(project_id, params = {})  # Input:
                                      ## project_id (string, required)
                                      ## params (hash)
                                      # Output:
                                      ## A JWT resource
```

For example:

```ruby
resp = @client.jwt("123.abcd")
resp.jwt # => 'eyJ0eXAiOi...`
```