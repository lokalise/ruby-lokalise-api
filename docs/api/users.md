---
---
# Users

## Fetch basic user info

```ruby
@client.user(user_id) # Input:
                      ## user_id (string or integer, required)
                      # Output:
                      ## User resource
```

For example:

```ruby
user = test_client.user 1234

user.id       # => 1234
user.uuid     # => '01655d20-4648-5d1e-8dd7-6216606b7819'
user.email    # => 'test@example.com'
user.fullname # => 'Test User'
```