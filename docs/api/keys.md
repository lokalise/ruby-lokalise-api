# Translation keys

[Key attributes](https://app.lokalise.com/api2docs/curl/#object-keys)

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
@client.keys project_id, limit: 2, page: 3
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
@client.key project_id, 44_596_066, disable_references: 0
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
@client.create_keys project_id, [{key_name: 'first_key', platforms: %w[ios]},
                                 {
                                   key_name: 'second_key',
                                   platforms: %w[web],
                                   translations: [{
                                     "language_iso": "en",
                                     "translation": "Welcome"
                                   }]
                                 }
                                ]
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

Alternatively:

```ruby
key = @client.key('project_id', 'key_id')
key.update(params)
```

For example:

```ruby
@client.update_key project_id, key_id, key_name: 'updated_key_name', description: 'Demo description'
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
client.update_keys '123.abc', [
  {
    key_id: 456,
    description: 'bulk updated'
  },
  {
    key_id: 769,
    tags: %w[bulk update]
  }
]
```

## Delete project key

[Doc](https://developers.lokalise.com/reference/delete-a-key)

```ruby
@client.destroy_key(project_id, key_id) # Input:
                                        ## project_id (string, required)
                                        ## key_id (string, required)
                                        # Output:
                                        ## Hash with project_id and "key_removed" set to "true"
```

Alternatively:

```ruby
key = @client.key('project_id', 'key_id')
key.destroy
```

## Bulk delete project keys

[Doc](https://developers.lokalise.com/reference/delete-multiple-keys)

```ruby
@client.destroy_keys(project_id, key_ids) # Input:
                                          ## project_id (string, required)
                                          ## key_ids (array, required)
                                          # Output:
                                          ## Hash with project_id and "keys_removed" set to "true"
```

Alternatively:

```ruby
keys = @client.keys('project_id')
keys.destroy_all # => will effectively destroy all keys in the project
```

For example:

```ruby
@client.destroy_keys project_id, [1234, 5678]
```
