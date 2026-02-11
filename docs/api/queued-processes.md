---
---
# Queued processes

## Fetch queued processes

[Doc](https://developers.lokalise.com/reference/list-all-processes)

```ruby
@client.queued_processes(project_id) # Input:
                                     ## project_id (string, required)
                                     # Output:
                                     ## Collection of queued processes
```

For example:

```ruby
project_id = '123.abc'
params = {
  page: 2,
  limit: 3
}

processes = @client.queued_processes project_id, params

processes[0].status # => 'finished'
```

Alternatively:

```ruby
project = @client.project project_id
processes = project.queued_processes params
```

## Fetch a single queued process

[Doc](https://developers.lokalise.com/reference/retrieve-a-process)

```ruby
@client.queued_process(project_id, process_id) # Input:
                                               ## project_id (string, required)
                                               ## process_id (string, required)
                                               # Output:
                                               ## Queued process resource
```

For example:

```ruby
project_id = '123.abc'
process_id = '1234'

process = @client.queued_process project_id, process_id

process.status # => 'finished'
```

Alternatively:

```ruby
project = @client.project project_id
process = project.queued_process process_id
```