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
@client.tasks project_id, limit: 2, page: 2
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
@client.create_task project_id, title: 'My first task',
                                keys: [1234, 5678],
                                languages: [
                                  {
                                    language_iso: 'ru',
                                    users: ['20181']
                                  }
                                ]
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

Alternatively:

```ruby
task = @client.task('project_id', 'task_id')
task.update(params)
```

For example:

```ruby
@client.update_task project_id, task_id, description: 'Updated task', auto_close_task: true
```

## Delete task

[Doc](https://developers.lokalise.com/reference/delete-a-task)

```ruby
@client.destroy_task(project_id, task_id)  # Input:
                                           ## project_id (string, required)
                                           ## task_id (string, required)
                                           # Output:
                                           ## Hash with the project id and "task_deleted" set to "true"

```

Alternatively:

```ruby
task = @client.task('project_id', 'task_id')
task.destroy
```
