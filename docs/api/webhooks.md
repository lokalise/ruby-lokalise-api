# Webhooks

[Webhook attributes](https://app.lokalise.com/api2docs/curl/#object-webhooks)

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
@client.webhooks project_id, limit: 1, page: 2
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
@client.create_webhook project_id,
                       url: 'http://example.com',
                       events: ['project.imported', 'project.exported']
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

Alternatively:

```ruby
webhook = @client.webhook(project_id, webhook_id)
webhook.update(params)
```

For example:

```ruby
@client.update_webhook project_id,
                       new_webhook_id,
                       url: 'http://updated.example.com'
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

Alternatively:

```ruby
webhook = @client.webhook(project_id, webhook_id)
webhook.destroy
```

## Regenerate webhook secret

[Doc](https://developers.lokalise.com/reference/regenerate-a-webhook-secret)

```ruby
@client.regenerate_webhook_secret(project_id, webhook_id) # Input:
                                                          ## project_id (string, required)
                                                          ## webhook_id (string, required)
                                                          # Output:
                                                          ## Hash containing `project_id` and new `secret`
```

Alternatively:

```ruby
webhook = @client.webhook(project_id, webhook_id)
webhook.regenerate_secret
```
