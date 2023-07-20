# Comments

## Fetch project comments

[Doc](https://developers.lokalise.com/reference/list-project-comments)

```ruby
@client.project_comments(project_id, params = {})   # Input:
                                                    ## project_id (string, required)
                                                    ## params (hash)
                                                    ### :page and :limit
                                                    # Output:
                                                    ## Collection of comments available in the given project
```

For example:

```ruby
project_id = '123.abc'
key_id = 1234

comments = test_client.project_comments project_id, key_id, page: 2, limit: 3

comments[0].comment_id # => 789
comments[0].comment # => '<p>Hi!</p>'
```

## Fetch key comments

[Doc](https://developers.lokalise.com/reference/list-key-comments)

```ruby
@client.comments(project_id, key_id, params = {})   # Input:
                                                    ## project_id (string, required)
                                                    ## key_id (string, required)
                                                    ## params (hash)
                                                    ### :page and :limit
                                                    # Output:
                                                    ## Collection of comments available for the specified key in the given project
```

For example:

```ruby
project_id = '123.abc'
key_id = 1234

comments = @client.comments project_id, key_id, limit: 1, page: 2

comments[0].comment_id # => 789
comments[0].comment # => '<p>Hi!</p>'
```

Alternatively:

```ruby
params = {
  page: 2,
  limit: 3
}

project = @client.project project_id

comments = project.key_comments key_id, params

# OR

key = @client.key project_id, key_id
comments = key.key_comments params
```

## Create key comments

[Doc](https://developers.lokalise.com/reference/create-comments)

```ruby
@client.create_comments(project_id, key_id, params)   # Input:
                                                      ## project_id (string, required)
                                                      ## key_id (string, required)
                                                      ## params (array or hash, required) - contains parameter of newly created comments. Pass array of hashes to create multiple comments, or a hash to create a single comment
                                                      ### :comment (string, required)
                                                      # Output:
                                                      ## Newly created comment
```

For example:

```ruby
params = [
  {comment: 'demo comment'},
  {comment: 'another comment'}
]

comments = @client.create_comments project_id, key_id, params

comments[0].comment # => 'demo comment'
```

Alternatively:

```ruby
project = @client.project project_id

comments = project.create_comments key_id, params

# OR

key = @client.key project_id, key_id
comments = key.create_comments params
```

## Fetch key comment

[Doc](https://developers.lokalise.com/reference/retrieve-a-comment)

```ruby
@client.comment(project_id, key_id, comment_id)   # Input:
                                                  ## project_id (string, required)
                                                  ## key_id (string, required)
                                                  ## comment_id (string, required)
                                                  # Output:
                                                  ## Comment for the key in the given project
```

For example:

```ruby
comment = @client.comment project_id, key_id, comment_id

comment.comment_id # => 1234
comment.comment # => '<p>Hi!</p>'
```

Alternatively:

```ruby
project = @client.project project_id

comment = project.key_comment key_id, comment_id

# OR

key = @client.key project_id, key_id
comment = key.key_comment comment_id
```

## Delete key comment

[Doc](https://developers.lokalise.com/reference/delete-a-comment)

```ruby
@client.destroy_comment(project_id, key_id, comment_id)   # Input:
                                                          ## project_id (string, required)
                                                          ## key_id (string, required)
                                                          ## comment_id (string, required)
                                                          # Output:
                                                          ## Generic object with the project id and "comment_deleted"=>true
```

For example:

```ruby
response = @client.destroy_comment project_id, key_id, comment_id

response.comment_deleted # => true
```

Alternatively:

```ruby
comment = @client.comment project_id, key_id, comment_id

response = comment.destroy

# OR

project = @client.project project_id
response = project.destroy_comment key_id, comment_id

# OR

key = @client.key project_id, key_id
response = key.destroy_comment comment_id
```
