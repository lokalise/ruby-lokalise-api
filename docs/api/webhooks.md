---
---
# Webhooks

## Fetch webhooks

[Doc](https://developers.lokalise.com/reference/list-all-webhooks)

```ruby
@client.webhooks(project_id, params = {}) # Input:
                                          ## project_id (string, required)
                                          ## params (hash)
                                          ### :page and :limit
                                          # Output:
                                          ## Collection of webhooks for the project
```

For example:

```ruby
project_id = '123.abc'
params = {
  limit: 3,
  page: 2
}

webhooks = @client.webhooks project_id, params

webhooks[0].webhook_id # => '12345'
```

Alternatively:

```ruby
project = @client.project project_id
webhooks = project.webhooks params
```

## Fetch a single webhook

[Doc](https://developers.lokalise.com/reference/retrieve-a-webhook)

```ruby
@client.webhook(project_id, webhook_id)   # Input:
                                          ## project_id (string, required)
                                          ## webhook_id (string, required)
                                          # Output:
                                          ## Webhook for the given project
```

For example:

```ruby
project_id = '123.abc'
webhook_id = '1234'

webhook = test_client.webhook project_id, webhook_id

webhook.url # => 'https://example.com'
webhook.events # => ['project.translation.proofread']
```

Alternatively:

```ruby
project = @client.project project_id
webhook = project.webhook webhook_id
```

## Create webhook

[Doc](https://developers.lokalise.com/reference/create-a-webhook)

```ruby
@client.create_webhook(project_id, params)    # Input:
                                              ## project_id (string, required)
                                              ## params (hash, required)
                                              ### :url (string, required) - webhook URL
                                              ### :events (array, required) - events to subscribe to. Check the API docs to find the list of supported events
                                              ### :event_lang_map (array) - map the event with an array of languages iso codes
                                              # Output:
                                              ## Created webhook
```

For example:

```ruby
params = {
  url: 'http://example.com',
  events: ['project.imported', 'project.exported']
}

webhook = @client.create_webhook project_id, params

webhook.url # => 'https://example.com'                  
```

Alternatively:

```ruby
project = @client.project project_id
webhook = project.create_webhook params
```

## Update webhook

[Doc](https://developers.lokalise.com/reference/update-a-webhook)

```ruby
@client.update_webhook(project_id, webhook_id, params)    # Input:
                                                          ## project_id (string, required)
                                                          ## webhook_id (string, required)
                                                          ## params (hash)
                                                          ### :url (string) - webhook URL
                                                          ### :events (array) - events to subscribe to. Check the API docs to find the list of supported events
                                                          ### :event_lang_map (array) - map the event with an array of languages iso codes
                                                          # Output:
                                                          ## Updated webhook
```

For example:

```ruby
params = {
  url: 'http://updated.example.com'
}

webhook = @client.update_webhook project_id, webhook_id, params

webhook.url # => 'http://updated.example.com'
```

Alternatively:

```ruby
webhook = @client.webhook project_id, webhook_id
webhook.update params

# OR

project = @client.project project_id
webhook = project.update_webhook webhook_id, params
```

## Delete webhook

[Doc](https://developers.lokalise.com/reference/delete-a-webhook)

```ruby
@client.destroy_webhook(project_id, webhook_id)   # Input:
                                                  ## project_id (string, required)
                                                  ## webhook_id (string, required)
                                                  # Output:
                                                  ## Result of the delete operation
```

For example:

```ruby
response = @client.destroy_webhook project_id, webhook_id
response.webhook_deleted # => true
```

Alternatively:

```ruby
webhook = @client.webhook project_id, webhook_id
response = webhook.destroy

# OR

project = @client.project project_id
response = project.destroy_webhook webhook_id
```

## Regenerate webhook secret

[Doc](https://developers.lokalise.com/reference/regenerate-a-webhook-secret)

```ruby
@client.regenerate_webhook_secret(project_id, webhook_id) # Input:
                                                          ## project_id (string, required)
                                                          ## webhook_id (string, required)
                                                          # Output:
                                                          ## Generic containing `project_id` and new `secret`
```

For example:

```ruby
response = @client.regenerate_webhook_secret project_id, webhook_id

response.secret # => '123abc'
```

Alternatively:

```ruby
webhook = @client.webhook project_id, webhook_id
response = webhook.regenerate_secret

# OR

project = @client.project project_id
response = @client.regenerate_webhook_secret webhook_id
```