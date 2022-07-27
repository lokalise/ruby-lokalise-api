# Snapshots

[Snapshot attributes](https://app.lokalise.com/api2docs/curl/#object-snapshots)

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
@client.snapshots project_id, limit: 1, page: 2
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
@client.create_snapshot project_id, title: 'My snapshot'
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

Alternatively:

```ruby
snapshot = @client.snapshots('project_id').first # you can't fetch a single snapshot
snapshot.restore
```

## Delete snapshot

[Doc](https://developers.lokalise.com/reference/delete-a-snapshot)

```ruby
@client.destroy_snapshot(project_id, snapshot_id)   # Input:
                                                    ## project_id (string, required)
                                                    ## snapshot_id (string, required)
                                                    # Output:
                                                    ## Hash with the project id and "snapshot_deleted" set to "true"
```

Alternatively:

```ruby
snapshot = @client.snapshots('project_id').first # you can't fetch a single snapshot
snapshot.destroy
```
