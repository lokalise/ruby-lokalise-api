# Branches

## Fetch branches

[Doc](https://developers.lokalise.com/reference/list-all-branches)

```ruby
@client.branches(project_id, params = {})   # Input:
                                            ## project_id (string, required)
                                            ## params (hash)
                                            ### :page and :limit
                                            # Output:
                                            ## Collection of branches
```

For example:

```ruby
branches = @client.branches '123.abc', limit: 1, page: 1

branches.project_id # => '123.abc'
branches[0].branch_id # => 123
branches[0].name # => 'branch_name'
```

Alternatively:

```ruby
project = @client.project '123.abc'

branches = project.branches limit: 1, page: 1
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

For example:

```ruby
branch_id = 1234

branch = @client.branch '123.abc', branch_id

branch.branch_id # => 1234
branch.name # => 'branch_name'
```

Alternatively:

```ruby
project = @client.project '123.abc'

branch = project.branch branch_id
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
branch = @client.create_branch '123.abc', name: 'ruby-branch'

branch.branch_id # => 1234
branch.name  # => 'ruby-branch'
```

Alternatively:

```ruby
project = @client.project '123.abc'

branch = project.create_branch name: 'ruby-branch'
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

For example:

```ruby
branch_id = 1234

branch = @client.update_branch '123.abc', branch_id, name: 'updated-ruby-branch'

branch.name # => 'updated-ruby-branch'
```

Alternatively:

```ruby
branch = @client.branch '123.abc', branch_id
updated_branch = branch.update params

# OR

project = @client.project '123.abc'

branch = project.update_branch branch_id, name: 'updated-ruby-branch'
```

## Delete branch

[Doc](https://developers.lokalise.com/reference/delete-a-branch)

```ruby
@client.destroy_branch(project_id, branch_id)   # Input:
                                                ## project_id (string, required)
                                                ## branch_id (string or integer, required)
                                                # Output:
                                                ## Generic object with `branch_deleted` method
```

For example:

```ruby
branch_id = 1234

result = @client.destroy_branch '123.abc', branch_id

result.project_id # => '123.abc'
result.branch_deleted # => true
```

Alternatively:

```ruby
branch = @client.branch '123.abc', branch_id
result = branch.destroy

# OR

project = @client.project '123.abc'

result = project.destroy_branch branch_id

result.branch_deleted # => true
```

## Merge branch

[Doc](https://developers.lokalise.com/reference/merge-a-branch)

```ruby
@client.merge_branch(project_id, branch_id, params) # Input:
                                                    ## project_id (string, required)
                                                    ## branch_id (string or integer, required)
                                                    ## params (hash)
                                                    # Output:
                                                    ## Generic object with the project's id, "branch_merged"=>true, and branch attributes
```

For example:

```ruby
branch_source = 1234
data = {
  force_conflict_resolve_using: 'source',
  target_branch_id: 6789
}

result = @client.merge_branch '123.abc', branch_source, data

result.branch_merged # => true
result.branch['branch_id'] # => 1234
result.target_branch['branch_id'] # => 6789
```

Alternatively:

```ruby
branch = @client.branch '123.abc', branch_source
result = branch.merge data

# OR

project = @client.project '123.abc'
result = project.merge_branch branch_source, data
```
