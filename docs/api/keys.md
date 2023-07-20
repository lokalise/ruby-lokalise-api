# Translation keys

## Fetch project keys

[Doc](https://developers.lokalise.com/reference/list-all-keys)

```ruby
@client.keys(project_id, params = {})   # Input:
                                        ## project_id (string, required)
                                        ## params (hash)
                                        ### :page and :limit
                                        # Output:
                                        ## Collection of keys available in the given project
```

For example:

```ruby
project_id = '123.abc'
params = {
  limit: 2,
  page: 3
}

keys = @client.keys project_id, params

keys[0].key_id # => 1234
```

Alternatively:

```ruby
project = @client.project project_id

keys = project.keys params
```

## Fetch a single project key

[Doc](https://developers.lokalise.com/reference/retrieve-a-key)

```ruby
@client.key(project_id, key_id, params = {})    # Input:
                                                ## project_id (string, required)
                                                ## key_id (string, required)
                                                ## params (hash)
                                                ### :disable_references (string) - possible values are "1" and "0".
                                                # Output:
                                                ## Project key
```

For example:

```ruby
project_id = '123.abc'
key_id = 44_596_066
params = {
  disable_references: 0
}

key = @client.key project_id, key_id, params

key.key_name['ios'] # => 'demo_key_name'
key.translations[0]['language_iso'] # => 'en'
```

Alternatively:

```ruby
project = @client.project project_id
key = project.key key_id, params
```

## Create project keys

[Doc](https://developers.lokalise.com/reference/create-keys)

```ruby
@client.create_keys(project_id, params)   # Input:
                                          ## project_id (string, required)
                                          ## params (array of hashes or hash, required)
                                          ### :key_name (string or hash, required) - for projects with enabled per-platform key names, pass hash with "ios", "android", "web" and "other" params.
                                          ### :platforms (array) - supported values are "ios", "android", "web" and "other"
                                          ### Find all other supported attributes at https://developers.lokalise.com/reference/create-keys
                                          # Output:
                                          ## Collection of newly created keys
```

For example:

```ruby
params = [
  {
    key_name: 'first_key',
    platforms: %w[ios]
  },
  {
    key_name: 'second_key',
    platforms: %w[web],
    translations: [
      {
        "language_iso": "en",
        "translation": "Welcome"
      }
    ]
  }
]

keys = @client.create_keys project_id, params

keys[0].key_id # => 1234
keys.errors[0]['message'] # => 'This key name is already taken'
```

Alternatively:

```ruby
project = @client.project project_id
keys = project.create_keys params
```

## Update project key

[Doc](https://developers.lokalise.com/reference/update-a-key)

```ruby
@client.update_key(project_id, key_id, params = {})   # Input:
                                                      ## project_id (string, required)
                                                      ## key_id (string, required)
                                                      ## params (hash)
                                                      ### Find a list of supported attributes at https://developers.lokalise.com/reference/update-a-key
                                                      # Output:
                                                      ## Updated key
```

For example:

```ruby
params = {
  key_name: 'updated_key_name',
  description: 'Demo description'
}

key = @client.update_key project_id, key_id, params

key.key_id # => 1234
```

Alternatively:

```ruby
key = @client.key project_id, key_id
key.update params

# OR

project = @client.project project_id
key = project.update_key key_id, params
```

## Bulk update project keys

[Doc](https://developers.lokalise.com/reference/bulk-update)

```ruby
@client.update_keys(project_id, params)  # Input:
                                         ## project_id (string, required)
                                         ## params (hash or array of hashes, required)
                                         ### :key_id (string, required)
                                         ### Find all other supported attributes at https://developers.lokalise.com/reference/bulk-update
                                         # Output:
                                         ## Collection of updated keys
```

For example:

```ruby
params = {
  use_automations: false,
  keys: [
    {
      key_id: 456,
      description: 'bulk updated'
    },
    {
      key_id: 769,
      tags: %w[bulk update]
    }
  ]
}

keys = client.update_keys project_id, params

keys[1].tags # => ['bulk', 'update']
```

Alternatively:

```ruby
project = @client.project project_id
keys = project.update_keys params
```

## Delete project key

[Doc](https://developers.lokalise.com/reference/delete-a-key)

```ruby
@client.destroy_key(project_id, key_id) # Input:
                                        ## project_id (string, required)
                                        ## key_id (string, required)
                                        # Output:
                                        ## Generic with project_id and "key_removed" set to "true"
```

For example:

```ruby
response = client.destroy_key project_id, key_id

response.key_removed # => true
```

Alternatively:

```ruby
key = @client.key project_id, key_id
response = key.destroy

# OR

project = @client.project project_id
response = project.destroy_key key_id
```

## Bulk delete project keys

[Doc](https://developers.lokalise.com/reference/delete-multiple-keys)

```ruby
@client.destroy_keys(project_id, key_ids) # Input:
                                          ## project_id (string, required)
                                          ## key_ids (array, required)
                                          # Output:
                                          ## Generic with project_id and "keys_removed" set to "true"
```

For example:

```ruby
key_ids = [1234, 5678]

response = @client.destroy_keys project_id, key_ids
response.keys_removed # => true
```

Alternatively:

```ruby
project = @client.project project_id
response = project.destroy_keys key_ids
```