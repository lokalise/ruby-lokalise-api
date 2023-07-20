# Tasks

## Fetch tasks

[Doc](https://developers.lokalise.com/reference/list-all-tasks)

```ruby
@client.tasks(project_id, params = {})  # Input:
                                        ## project_id (string, required)
                                        ## params (hash)
                                        ### :filter_title (string) - set title filter for the list
                                        ### :page and :limit
                                        # Output:
                                        ## Collection of tasks for the project
```

For example:

```ruby
project_id = '123.abc'
params = {
  limit: 3,
  page: 2
}

tasks = @client.tasks project_id, params

tasks[0].task_id # => '1234'
```

Alternatively:

```ruby
project = @client.project project_id
tasks = project.tasks params
```

## Fetch a single task

[Doc](https://developers.lokalise.com/reference/retrieve-a-task)

```ruby
@client.task(project_id, task_id)  # Input:
                                   ## project_id (string, required)
                                   ## task_id (string, required)
                                   # Output:
                                   ## Single task for the project
```

For example:

```ruby
project_id = '123.abc'
task_id = '1234'

task = @client.task project_id, task_id

task.title # => 'Demo'
task.status # => 'created'
```

Alternatively:

```ruby
project = @client.project project_id
task = project.task task_id
```

## Create task

[Doc](https://developers.lokalise.com/reference/create-a-task)

```ruby
@client.create_task(project_id, params)  # Input:
                                         ## project_id (string, required)
                                         ## params (hash, required)
                                         ### title (string, required)
                                         ### keys (array) - translation key ids. Required if "parent_task_id" is not specified
                                         ### languages (array of hashes, required)
                                         #### language_iso (string)
                                         #### users (array) - list of users identifiers, assigned to work on the language
                                         ### Find other supported options at https://developers.lokalise.com/reference/create-a-task
                                         # Output:
                                         ## A newly created task

```

For example:

```ruby
params = {
  title: 'Demo task',
  keys: %w[1234 5678],
  languages: [
    {
      language_iso: 'de',
      users: %w[1234]
    }
  ],
  source_language_iso: 'en',
  task_type: 'translation'
}

task = @client.create_task project_id, params

task.status # => 'created'
```

Alternatively:

```ruby
project = @client.project project_id
task = project.create_task params
```

## Update task

[Doc](https://developers.lokalise.com/reference/update-a-task)

```ruby
@client.update_task(project_id, task_id, params = {})  # Input:
                                                       ## project_id (string, required)
                                                       ## task_id (string or integer, required)
                                                       ## params (hash)
                                                       ### Find supported params at https://developers.lokalise.com/reference/update-a-task
                                                       # Output:
                                                       ## An updated task

```

For example:

```ruby
params = {
  description: 'Updated task',
  auto_close_task: true
}

task = @client.update_task project_id, task_id, params

task.description # => 'Updated task'
```

Alternatively:

```ruby
task = @client.task project_id, task_id
task.update params

# OR

project = @client.project project_id
task = project.update_task params
```

## Delete task

[Doc](https://developers.lokalise.com/reference/delete-a-task)

```ruby
@client.destroy_task(project_id, task_id)  # Input:
                                           ## project_id (string, required)
                                           ## task_id (string, required)
                                           # Output:
                                           ## Generic with the project id and "task_deleted" set to "true"

```

For example:

```ruby
response = client.destroy_task project_id, task_id

response.task_deleted # => true
```

Alternatively:

```ruby
task = @client.task project_id, task_id
response = task.destroy

# OR

project = @client.project project_id
response = project.destroy_task task_id
```