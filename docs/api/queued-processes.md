# Queued processes

## Fetch queued processes

[Doc](https://developers.lokalise.com/reference/list-all-processes)

```ruby
@client.queued_processes(project_id) # Input:
                                     ## project_id (string, required)
                                     # Output:
                                     ## Collection of queued processes
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
