# Contributors

## Fetch contributors

[Doc](https://developers.lokalise.com/reference/list-all-contributors)

```ruby
@client.contributors(project_id, params = {})   # Input:
                                                ## project_id (string, required)
                                                ## params (hash)
                                                ### :page and :limit
                                                # Output:
                                                ## Collection of contributors in the given project
```

For example:

```ruby
project_id = '123.abc'

contributors = @client.contributors project_id, limit: 1, page: 2

contributors[0].fullname # => 'John Doe'
contributors[0].email # => 'test@example.com'
```

Alternatively:

```ruby
project = @client.project project_id

contributors = project.contributors limit: 1, page: 2
```

## Fetch a single contributor

[Doc](https://developers.lokalise.com/reference/retrieve-a-contributor)

```ruby
@client.contributor(project_id, contributor_id)   # Input:
                                                  ## project_id (string, required)
                                                  ## contributor_id (string, required) - named as "user_id" in the response
                                                  # Output:
                                                  ## Contributor in the given project
```

For example:

```ruby
project_id = '123.abc'
contributor_id = '1234'

contributor = @client.contributor project_id, contributor_id

contributor.user_id # => 1234
contributor.fullname # => 'John Doe'
contributor.email # => 'test@example.com'
```

Alternatively:

```ruby
project = @client.project project_id

contributor = project.contributor contributor_id
```

## Create contributors

[Doc](https://developers.lokalise.com/reference/create-contributors)

```ruby
@client.create_contributors(project_id, params)  # Input:
                                                 ## project_id (string, required)
                                                 ## params (array of hashes or hash, required) - parameters for the newly created contributors. Pass array of hashes to create multiple contributors, or a hash to create a single contributor
                                                 ### :email (string, required)
                                                 ### :fullname (string)
                                                 ### :is_admin (boolean)
                                                 ### :is_reviewer (boolean)
                                                 ### :languages (array of hashes, required if "is_admin" set to false) - possible languages attributes:
                                                 #### :lang_iso (string, required)
                                                 #### :is_writable (boolean)
                                                 ### :admin_rights (array)
                                                 # Output:
                                                 ## Collection of newly created contributors
```

For example:

```ruby
params = {
  email: 'test@example.com',
  fullname: 'John Doe',
  languages: [{
    lang_iso: 'en'
  },
  {
    lang_iso: 'lv'
  }]
}

contributors = @client.create_contributors project_id, params
           
contributors[0].fullname # => 'John Doe'
```

Alternatively:

```ruby
project = @client.project project_id

contributors = project.create_contributors params
```

## Update contributor

[Doc](https://developers.lokalise.com/reference/update-a-contributor)

```ruby
@client.update_contributor(project_id, contributor_id, params)   # Input:
                                                                 ## project_id (string, required)
                                                                 ## contributor_id (string, required)
                                                                 ## params (hash, required)
                                                                 ### :is_admin (boolean)
                                                                 ### :is_reviewer (boolean)
                                                                 ### :languages (array of hashes) - possible languages attributes:
                                                                 #### :lang_iso (string, required)
                                                                 #### :is_writable (boolean)
                                                                 ### :admin_rights (array)
                                                                 # Output:
                                                                 ## Updated contributor
```

For example:

```ruby
params = { languages: [{lang_iso: 'en'}] }

contributor = @client.update_contributor project_id, contributor_id, params
```

Alternatively:

```ruby
contributor = @client.contributor project_id, contributor_id
contributor.update params

# OR 

project = @client.project project_id
project.update_contributor contributor_id, params
```

## Delete contributor

[Doc](https://developers.lokalise.com/reference/delete-a-contributor)

```ruby
@client.destroy_contributor(project_id, contributor_id)    # Input:
                                                           ## project_id (string, required)
                                                           ## contributor_id (string, required)
                                                           # Output:
                                                           ## Generic object with the project id and "contributor_deleted"=>true
```

For example:

```ruby
response = @client.destroy_contributor project_id, contributor_id

response.contributor_deleted # => true
```

Alternatively:

```ruby
contributor = @client.contributor project_id, contributor_id
response = contributor.destroy

# OR

project = @client.project project_id
response = project.destroy_contributor contributor_id
```