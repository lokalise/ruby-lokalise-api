---
---
# JWT

## Create JWT

[Doc](https://developers.lokalise.com/reference/create-service-jwt)

```ruby
@client.create_jwt(project_id, params = {}) # Input:
                                            ## project_id (string, required)
                                            ## params (hash)
                                            # Output:
                                            ## A JWT resource
```

For example:

```ruby
project_id = "123.abcd"

response = @client.create_jwt project_id, service: :ota

response.jwt # => 'eyJ0eXAiOi...`
```

Alternatively:

```ruby
project = @client.project project_id

response = project.create_jwt service: :ota
```