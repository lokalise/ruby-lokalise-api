# Custom translation statuses

*Custom translation statuses must be enabled for the project before using this endpoint!* It can be done in the project settings.

## Fetch translation statuses

[Doc](https://developers.lokalise.com/reference/list-all-custom-translation-statuses)

```ruby
@client.custom_translation_statuses(project_id, params = {})  # Input:
                                                              ## project_id (string, required)
                                                              ## params (hash)
                                                              ### :page and :limit
                                                              # Output:
                                                              ## Collection of custom translation statuses for the project
```

For example:

```ruby
project_id = '123.abc'
params = { limit: 1, page: 2 }

statuses = @client.custom_translation_statuses project_id, params
statuses[0].color # => '#0079bf'
```

Alternatively:

```ruby
project = @client.project project_id

statuses = project.custom_translation_statuses params
```

## Fetch a single translation status

[Doc](https://developers.lokalise.com/reference/retrieve-a-custom-translation-status)

```ruby
@client.custom_translation_status(project_id, status_id)  # Input:
                                                          ## project_id (string, required)
                                                          ## status_id (string or integer, required)
                                                          # Output:
                                                          ## Translation status inside the given project
```

For example:

```ruby
project_id = '123.abc'
status_id = '1234'

status = @client.custom_translation_status project_id, status_id

status.color # => '#0079bf'
status.title # => 'approved'
```

Alternatively:

```ruby
project = @client.project project_id

status = project.custom_translation_status status_id
```

## Create translation status

[Doc](https://developers.lokalise.com/reference/create-a-custom-translation-status)

```ruby
@client.create_custom_translation_status(project_id, params)  # Input:
                                                              ## project_id (string, required)
                                                              ## params (hash, required)
                                                              ### :title (string, required) - title of the new status
                                                              ### :color (string, required) - HEX color code of the new status. Lokalise allows a very limited number of color codes to set. Check the official docs or use `#translation_status_colors` method listed below to find the list of supported colors
                                                              # Output:
                                                              ## Created translation status
```

For example:

```ruby
params = {
  title: "approved",
  color: '#f2d600'
}

status = @client.create_custom_translation_status project_id, params

status.color # => '#f2d600'
status.title # => 'approved'
```

Alternatively:

```ruby
project = @client.project project_id

status = project.create_custom_translation_status params
```

## Update translation status

[Doc](https://developers.lokalise.com/reference/update-a-custom-translation-status)

```ruby
@client.update_custom_translation_status(project_id, status_id, params)   # Input:
                                                                          ## project_id (string, required)
                                                                          ## status_id (string or integer, required)
                                                                          ## params (hash, required)
                                                                          ### :title (string, required) - title of the new status
                                                                          ### :color (string, required) - HEX color code of the new status
                                                                          # Output:
                                                                          ## Updated translation status
```

For example:

```ruby
params = {
  title: 'Updated status',
  color: '#c377e0'
}

status = @client.update_custom_translation_status project_id, status_id, params
status.color # => '#c377e0'
```

Alternatively:

```ruby
status = @client.custom_translation_status project_id, status_id
status.update params

# OR

project = @client.project project_id
status = project.update_custom_translation_status status_id, params
```

## Delete translation status

[Doc](https://developers.lokalise.com/reference/delete-a-custom-translation-status)

```ruby
@client.destroy_custom_translation_status(project_id, status_id)  # Input:
                                                                  ## project_id (string, required)
                                                                  ## status_id (string or integer, required)
                                                                  # Output:
                                                                  ## Result of the delete operation
```

For example:

```ruby
response = @client.destroy_custom_translation_status project_id, status_id

response.custom_translation_status_deleted # => true
```

Alternatively:

```ruby
status = @client.custom_translation_status project_id, status_id
response = status.destroy

# OR

project = @client.project project_id
response = project.destroy_custom_translation_status status_id
```

## Supported color codes for translation statuses

[Doc](https://developers.lokalise.com/reference/retrieve-available-colors-for-custom-translation-statuses)

As long as Lokalise supports only very limited array of color hexadecimal codes for custom translation statuses, this method can be used to fetch all permitted values.

```ruby
@client.custom_translation_status_colors(project_id)  # Input:
                                                      ## project_id (string, required)
                                                      # Output:
                                                      ## Object responding to colors method that return an array of color codes in HEX format
```

For example:

```ruby
response = test_client.custom_translation_status_colors project_id

response.colors[0] # => '#61bd4f'
```

Alternatively:

```ruby
project = @client.project project_id
response = project.custom_translation_status_colors
```