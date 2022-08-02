# Custom translation statuses

*Custom translation statuses must be enabled for the project before using this endpoint!* It can be done in the project settings.

## Fetch translation statuses

[Doc](https://developers.lokalise.com/reference/list-all-custom-translation-statuses)

```ruby
@client.translation_statuses(project_id, params = {}) # Input:
                                                      ## project_id (string, required)
                                                      ## params (hash)
                                                      ### :page and :limit
                                                      # Output:
                                                      ## Collection of translation statuses for the project
```

For example:

```ruby
@client.translation_statuses project_id, limit: 1, page: 2
```

## Fetch a single translation status

[Doc](https://developers.lokalise.com/reference/retrieve-a-custom-translation-status)

```ruby
@client.translation_status(project_id, status_id) # Input:
                                                  ## project_id (string, required)
                                                  ## status_id (string or integer, required)
                                                  # Output:
                                                  ## Translation status inside the given project
```

## Create translation status

[Doc](https://developers.lokalise.com/reference/create-a-custom-translation-status)

```ruby
@client.create_translation_status(project_id, params) # Input:
                                                      ## project_id (string, required)
                                                      ## params (hash, required)
                                                      ### :title (string, required) - title of the new status
                                                      ### :color (string, required) - HEX color code of the new status. Lokalise allows a very limited number of color codes to set. Check the official docs or use `#translation_status_colors` method listed below to find the list of supported colors
                                                      # Output:
                                                      ## Created translation status
```

For example:

```ruby
@client.create_translation_status project_id,
                                  title: "Demo status",
                                  color: '#f2d600'
```

## Update translation status

[Doc](https://developers.lokalise.com/reference/update-a-custom-translation-status)

```ruby
@client.update_translation_status(project_id, status_id, params)  # Input:
                                                                  ## project_id (string, required)
                                                                  ## status_id (string or integer, required)
                                                                  ## params (hash, required)
                                                                  ### :title (string, required) - title of the new status
                                                                  ### :color (string, required) - HEX color code of the new status
                                                                  # Output:
                                                                  ## Updated translation status
```

Alternatively:

```ruby
status = @client.translation_status(project_id, status_id)
status.update(params)
```

For example:

```ruby
@client.update_translation_status project_id, status_id,
                                  title: 'Updated status',
                                  color: '#c377e0'
```

## Delete translation status

[Doc](https://developers.lokalise.com/reference/delete-a-custom-translation-status)

```ruby
@client.destroy_translation_status(project_id, status_id) # Input:
                                                          ## project_id (string, required)
                                                          ## status_id (string or integer, required)
                                                          # Output:
                                                          ## Result of the delete operation
```

Alternatively:

```ruby
status = @client.translation_status(project_id, status_id)
status.destroy
```

## Supported color codes for translation statuses

[Doc](https://developers.lokalise.com/reference/retrieve-available-colors-for-custom-translation-statuses)

As long as Lokalise supports only very limited array of color hexadecimal codes for custom translation statuses, this method can be used to fetch all permitted values.

```ruby
@client.translation_status_colors(project_id) # Input:
                                              ## project_id (string, required)
                                              # Output:
                                              ## Array of color codes in HEX format
```
