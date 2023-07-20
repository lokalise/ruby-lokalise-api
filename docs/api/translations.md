# Translations

## Fetch translations

[Doc](https://developers.lokalise.com/reference/list-all-translations)

```ruby
@client.translations(project_id, params = {})   # Input:
                                                ## project_id (string, required)
                                                ## params (hash)
                                                ### Find full list in the docs
                                                ### :page and :limit
                                                # Output:
                                                ## Collection of translations for the project
```

For example:

```ruby
project_id = '123.abc'

params = {
  limit: 4,
  page: 2,
  disable_references: 0,
  filter_is_reviewed: 0
}

translations = @client.translations project_id, params

translations[0].translation_id # => 1234
```

Alternatively:

```ruby
project = @client.project project_id
translations = project.translations params
```

## Fetch a single translation

[Doc](https://developers.lokalise.com/reference/retrieve-a-translation)

```ruby
@client.translation(project_id, translation_id, params = {})   # Input:
                                                                ## project_id (string, required)
                                                                ## translation_id (string, required)
                                                                ## params (hash)
                                                                ### :disable_references (string) - whether to disable key references. Supported values are 0 and 1
                                                                # Output:
                                                                ## Single translation for the project
```

For example:

```ruby
project_id = '123.abc'
translation_id = '1234'
params = {
  disable_references: 1
}

translation = test_client.translation project_id, translation_id, params

translation.language_iso # => 'en'
translation.is_reviewed # => true
```

Alternatively:

```ruby
project = @client.project project_id
translation = project.translation translation_id, params
```

## Update translation

[Doc](https://developers.lokalise.com/reference/update-a-translation)

```ruby
@client.update_translation(project_id, translation_id, params = {})   # Input:
                                                                      ## project_id (string, required)
                                                                      ## translation_id (string, required)
                                                                      ## params (hash, required)
                                                                      ### :translation (string or hash, required) - the actual translation. Provide hash for plural keys.
                                                                      ### :is_fuzzy (boolean)
                                                                      ### :is_reviewed (boolean)
                                                                      # Output:
                                                                      ## Updated translation
```

For example:

```ruby
params = {
  translation: 'Updated translation',
  is_reviewed: true
}

updated_translation = @client.update_translation project_id, translation_id, params

updated_translation.translation # => 'Updated translation'
```

Alternatively:

```ruby
translation = @client.translation project_id, translation_id
translation.update params

# OR

project = @client.project project_id
updated_translation = project.update_translation translation_id, params
```