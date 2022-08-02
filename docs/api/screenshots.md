# Screenshots

## Fetch screenshots

[Doc](https://developers.lokalise.com/reference/list-all-screenshots)

```ruby
@client.screenshots(project_id, params = {})  # Input:
                                              ## project_id (string, required)
                                              ## params (hash)
                                              ### :page and :limit
                                              # Output:
                                              ## Collection of project screenshots
```

For example:

```ruby
@client.screenshots project_id, limit: 1, page: 1
```

## Fetch a single screenshot

[Doc](https://developers.lokalise.com/reference/retrieve-a-screenshot)

```ruby
@client.screeshot(project_id, screeshot_id)     # Input:
                                                ## project_id (string, required)
                                                ## screeshot_id (string, required)
                                                # Output:
                                                ## A single screenshot
```

## Create screenshots

[Doc](https://developers.lokalise.com/reference/create-screenshots)

```ruby
@client.create_screenshots(project_id, params)     # Input:
                                                   ## project_id (string, required)
                                                   ## params (hash or array of hashes, required)
                                                   ### :data (string, required) - the actual screenshot, base64-encoded (with leading image type "data:image/jpeg;base64,"). JPG and PNG formats are supported.
                                                   ### :title (string)
                                                   ### :description (string)
                                                   ### :ocr (boolean) - recognize translations on the image and attach screenshot to all possible keys
                                                   ### :key_ids (array) - attach the screenshot to key IDs specified
                                                   ### :tags (array)
                                                   # Output:
                                                   ## Collection of created screenshots
```

For example:

```ruby
@client.create_screenshots project_id, data: 'data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAAH0AAA...', title: 'My screen'
```

## Update screenshot

[Doc](https://developers.lokalise.com/reference/update-a-screenshot)

```ruby
@client.update_screenshot(project_id, screenshot_id, params = {}) # Input:
                                                                  ## project_id (string, required)
                                                                  ## screenshot_id (string, required)
                                                                  ## params (hash)
                                                                  ### :title (string)
                                                                  ### :description (string)
                                                                  ### :key_ids (array) - attach the screenshot to key IDs specified
                                                                  ### :tags (array)
                                                                  # Output:
                                                                  ## Updated screenshot
```

Alternatively:

```ruby
screenshot = @client.screenshot('project_id', 'screen_id')
screenshot.update(params)
```

For example:

```ruby
@client.update_screenshot project_id, screenshot_id,
                          tags: %w[demo sample],
                          description: 'Sample screen'
```

## Delete screenshot

[Doc](https://developers.lokalise.com/reference/delete-a-screenshot)

```ruby
@client.destroy_screenshot(project_id, screenshot_id)   # Input:
                                                        ## project_id (string, required)
                                                        ## screenshot_id (string, required)
                                                        # Output:
                                                        ## Hash with the project id and "screenshot_deleted" set to "true"
```

Alternatively:

```ruby
screenshot = @client.screenshot('project_id', 'screen_id')
screenshot.destroy
```
