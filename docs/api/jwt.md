# JWT

## Get OTA JWT

[Doc](https://developers.lokalise.com/reference/get-ota-jwt)

```ruby
@client.jwt # Output:
            ## A JWT resource
```

For example:

```ruby
resp = @client.jwt
resp.jwt # => 'eyJ0eXAiOi...`
```