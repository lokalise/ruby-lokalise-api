---
---
# Snapshots

## Fetch snapshots

[Doc](https://developers.lokalise.com/reference/list-all-snapshots)

```ruby
@client.snapshots(project_id, params = {})  # Input:
                                            ## project_id (string, required)
                                            ## params (hash)
                                            ### :filter_title (string) - set title filter for the list
                                            ### :page and :limit
                                            # Output:
                                            ## Collection of project snapshots
```

For example:

```ruby
project_id = '123.abc'
params = {
  limit: 1,
  page: 2
}

snapshots = @client.snapshots project_id, params

snapshots[0].snapshot_id # => 5678
```

Alternatively:

```ruby
project = @client.project project_id
snapshots = project.snapshots params
```

## Create snapshot

[Doc](https://developers.lokalise.com/reference/create-a-snapshot)

```ruby
@client.create_snapshot(project_id, params = {})  # Input:
                                                  ## project_id (string, required)
                                                  ## params (hash)
                                                  ### :title (string)
                                                  # Output:
                                                  ## Created snapshot
```

For example:

```ruby
params = {
  title: 'My snapshot'
}

snapshot = @client.create_snapshot project_id, params

snapshot.title # => 'My snapshot'
```

Alternatively:

```ruby
project = @client.project project_id
snapshot = project.create_snapshot params
```

## Restore snapshot

[Doc](https://developers.lokalise.com/reference/restore-a-snapshot)

```ruby
@client.restore_snapshot(project_id, snapshot_id)   # Input:
                                                    ## project_id (string, required)
                                                    ## snapshot_id (string, required)
                                                    # Output:
                                                    ## Information about the restored project from the specified snapshot
```

For example:

```ruby
restored_project = test_client.restore_snapshot project_id, snapshot_id

restored_project.name # => 'Project copy'
```

Alternatively:

```ruby
snapshot = @client.snapshots(project_id).first
restored_project = snapshot.restore

# OR

project = @client.project project_id
restored_project = project.restore_snapshot snapshot_id
```

## Delete snapshot

[Doc](https://developers.lokalise.com/reference/delete-a-snapshot)

```ruby
@client.destroy_snapshot(project_id, snapshot_id)   # Input:
                                                    ## project_id (string, required)
                                                    ## snapshot_id (string, required)
                                                    # Output:
                                                    ## Generic with the project id and "snapshot_deleted" set to "true"
```

For example:

```ruby
response = @client.destroy_snapshot project_id, snapshot_id

response.snapshot_deleted # => true
```

Alternatively:

```ruby
snapshot = @client.snapshots(project_id).first
response = snapshot.destroy
```