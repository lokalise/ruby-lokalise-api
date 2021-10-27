# Translations

[Translation attributes](https://app.lokalise.com/api2docs/curl/#resource-translations)

## Fetch translations

[Doc](https://app.lokalise.com/api2docs/curl/#transition-list-all-translations-get)

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
@client.translations project_id, limit: 4, page: 2, disable_references: 0,
                                 filter_is_reviewed: 0
```

## Fetch a single translation

[Doc](https://app.lokalise.com/api2docs/curl/#transition-retrieve-a-translation-get)

```ruby
@client.translation(project_id, translation_id, params = {})   # Input:
                                                                ## project_id (string, required)
                                                                ## translation_id (string, required)
                                                                ## params (hash)
                                                                ### :disable_references (string) - whether to disable key references. Supported values are 0 and 1
                                                                # Output:
                                                                ## Single translation for the project
```

## Update translation

[Doc](https://app.lokalise.com/api2docs/curl/#transition-update-a-translation-put)

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

Alternatively:

```ruby
translation = @client.translation('project_id', 'translation_id')
translation.update(params)
```

For example:

```ruby
@client.update_translation project_id, translation_id, translation: 'Updated translation',
                                                       is_reviewed: true
```