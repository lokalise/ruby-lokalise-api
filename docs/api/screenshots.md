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
project_id = '123.abc'
params = {
  limit: 3,
  page: 1
}

screenshots = @client.screenshots project_id, params

screenshots[0].screenshot_id # => 1234
```

Alternatively:

```ruby
project = @client.project project_id
screenshots = project.screenshots params
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

For example:

```ruby
project_id = '123.abc'
screenshot_id = '1234'

screenshot = @client.screenshot project_id, screenshot_id

screenshot.keys[0]['key_id'] # => 6789
screenshot.width # => 572
```

Alternatively:

```ruby
project = @client.project project_id
screenshot = project.screenshot screenshot_id
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
params = {
  data: 'data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAAH0AAA...',
  title: 'My screen'
}

screenshots = @client.create_screenshots project_id, params

screenshots[0].title # => 'My screen'
```

Alternatively:

```ruby
project = @client.project project_id
screenshots = project.create_screenshots params
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

For example:

```ruby
params = {
  tags: %w[demo sample],
  description: 'Sample screen'
}

screenshot = @client.update_screenshot project_id, screenshot_id, params

screenshot.tags # => ['demo', 'sample']
```

Alternatively:

```ruby
screenshot = @client.screenshot project_id, screenshot_id
screenshot.update params

# OR

project = @client.project project_id
screenshot = project.update_screenshot screenshot_id, params
```

## Delete screenshot

[Doc](https://developers.lokalise.com/reference/delete-a-screenshot)

```ruby
@client.destroy_screenshot(project_id, screenshot_id)   # Input:
                                                        ## project_id (string, required)
                                                        ## screenshot_id (string, required)
                                                        # Output:
                                                        ## Generic with the project id and "screenshot_deleted" set to "true"
```

For example:

```ruby
response = @client.destroy_screenshot project_id, screen_id
response.screenshot_deleted # => true
```

Alternatively:

```ruby
screenshot = @client.screenshot project_id, screen_id
response = screenshot.destroy

# OR

project = @client.project project_id
response = project.destroy_screenshot screen_id
```