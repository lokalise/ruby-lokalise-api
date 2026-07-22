---
---

# Audit logs

## Fetch audit logs

[Doc](https://developers.lokalise.com/reference/list-audit-logs)

This endpoint requires `RubyLokaliseApi::ClientV1`. It is not available through the regular `RubyLokaliseApi::Client`.

```ruby
@client = RubyLokaliseApi::ClientV1.new(api_token)
```

```ruby
@client.audit_logs(params = {})   # Input:
                                  ## params (hash)
                                  ### :limit, :cursor, :date_from, :date_to,
                                  ### :event_type, :project_id, and :user_id
                                  # Output:
                                  ## Collection of audit log events
```

For example:

```ruby
audit_logs = @client.audit_logs limit: 100, event_type: 'project.deleted'

audit_logs[0].class_name # => 'API Activity'
audit_logs[0].metadata['event_code'] # => 'project.deleted'

audit_logs.has_more # => true
audit_logs.next_cursor # => 'eyJpZ...'
```

To fetch the next set of results, pass `next_cursor` as the `cursor` parameter:

```ruby
next_audit_logs = @client.audit_logs(
  limit: 100,
  cursor: audit_logs.next_cursor
)
```
