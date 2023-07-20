# Projects

## Fetch projects

[Doc](https://developers.lokalise.com/reference/list-all-projects)

```ruby
@client.projects(params = {})   # Input:
                                ## params (hash)
                                ### :filter_team_id (string) - load projects only for the given team
                                ### :page and :limit
                                # Output:
                                ## Collection of projects under the `projects` attribute
```

For example:

```ruby
params = {
  limit: 1,
  page: 2
}

projects = @client.projects 

projects[0].project_id # => '123.abc'
```

## Fetch a single project

[Doc](https://developers.lokalise.com/reference/retrieve-a-project)

```ruby
@client.project(project_id)     # Input:
                                ## project_id (string, required)
                                # Output:
                                ## A single project
```

For example:

```ruby
project_id = '123.abc'

project = @client.project project_id

project.project_type # => 'localization_files'
project.name # => 'Demo project'
```

## Create a project

[Doc](https://developers.lokalise.com/reference/create-a-project)

```ruby
@client.create_project(params)  # Input:
                                ## params (hash, required)
                                ### name (string, required)
                                ### description (string)
                                ### team_id (integer) - you must be an admin of the chosen team. When omitted, defaults to the current team of the token's owner
                                # Output:
                                ## A newly created project

```

For example:

```ruby
params = {
  name: 'Demo project',
  description: 'My first project'
}

project = @client.create_project params

project.name # => 'Demo project'
project.description # => 'My first project'
```

## Update a project

[Doc](https://developers.lokalise.com/reference/update-a-project)

```ruby
@client.update_project(project_id, params)  # Input:
                                            ## project_id (string, required)
                                            ## params (hash, required)
                                            ### name (string, required)
                                            ### description (string)
                                            # Output:
                                            ## An updated project
```

For example:

```ruby
params = {
  name: 'Updated project name',
  description: 'Updated project desc'
}

project = @client.update_project project_id, params

project.name # => 'Updated project name'            
```

Alternatively:

```ruby
project = @client.project project_id
project.update params
```

## Empty a project

[Doc](https://developers.lokalise.com/reference/empty-a-project)

Deletes *all* keys and translations from the project.

```ruby
@client.empty_project(project_id)   # Input:
                                    ## project_id (string, required)
                                    # Output:
                                    ## Generic containing project id and a `keys_deleted => true` attribute
```

For example:

```ruby
response = @client.empty_project project_id

response.keys_deleted # => true
```

Alternatively:

```ruby
project = @client.project project_id
response = project.empty
```

## Delete a project

[Doc](https://developers.lokalise.com/reference/delete-a-project)

```ruby
@client.destroy_project(project_id)   # Input:
                                      ## project_id (string, required)
                                      # Output:
                                      ## Generic containing project id and a `project_deleted => true` attribute
```

For example:

```ruby
response = client.destroy_project project_id
response.project_deleted # => true
```

Alternatively:

```ruby
project = @client.project project_id
response = project.destroy
```