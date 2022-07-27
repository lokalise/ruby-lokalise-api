# Branches

[Branches attributes](https://app.lokalise.com/api2docs/curl/#resource-branches)

## Fetch branches

[Doc](https://developers.lokalise.com/reference/list-all-branches)

```ruby
@client.branches(project_id, params = {})   # Input:
                                            ## project_id (string, required)
                                            ## params (hash)
                                            ### :page and :limit
                                            # Output:
                                            ## Collection of comments available in the branches project
```

For example:

```ruby
@client.branches project_id, limit: 1, page: 1
```

## Fetch branch

[Doc](https://developers.lokalise.com/reference/retrieve-a-branch)

```ruby
@client.branch(project_id, branch_id)   # Input:
                                        ## project_id (string, required)
                                        ## branch_id (string or integer, required)
                                        # Output:
                                        ## Branch inside the given project
```

## Create branch

[Doc](https://developers.lokalise.com/reference/retrieve-a-branch)

```ruby
@client.create_branch(project_id, params)   # Input:
                                            ## project_id (string, required)
                                            ## params (hash, required):
                                            ### :name (string) - name of the branch
                                            # Output:
                                            ## Created branch
```

For example:

```ruby
@client.create_branch project_id, name: 'ruby-branch'
```

## Update branch

[Doc](https://developers.lokalise.com/reference/update-a-branch)

```ruby
@client.update_branch(project_id, branch_id, params)    # Input:
                                                        ## project_id (string, required)
                                                        ## branch_id (string or integer, required)
                                                        ## params (hash, required):
                                                        ### :name (string) - name of the branch
                                                        # Output:
                                                        ## Updated branch
```

Alternatively:

```ruby
branch = @client.branch('project_id', 'branch_id')
branch.update params
```

For example:

```ruby
@client.update_branch project_id, branch_id, name: 'updated-ruby-branch'
```

## Delete branch

[Doc](https://developers.lokalise.com/reference/delete-a-branch)

```ruby
@client.destroy_branch(project_id, branch_id)   # Input:
                                                ## project_id (string, required)
                                                ## branch_id (string or integer, required)
                                                # Output:
                                                ## Hash with the project's id and "branch_deleted"=>true
```

Alternatively:

```ruby
branch = @client.branch('project_id', 'branch_id')
branch.destroy
```

## Merge branch

[Doc](https://developers.lokalise.com/reference/merge-a-branch)

```ruby
@client.merge_branch(project_id, branch_id, params) # Input:
                                                    ## project_id (string, required)
                                                    ## branch_id (string or integer, required)
                                                    ## params (hash)
                                                    # Output:
                                                    ## Hash with the project's id, "branch_merged"=>true, and branch attributes
```

Alternatively:

```ruby
branch = @client.branch('project_id', 'branch_id')
branch.merge params
```

For example:

```ruby
@client.merge_branch project_id, branch_id, force_conflict_resolve_using: 'master'
```
