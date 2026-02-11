---
---
# Languages

## Fetch system languages

[Doc](https://developers.lokalise.com/reference/list-system-languages)

```ruby
@client.system_languages(params = {})   # Input:
                                        ## params (hash)
                                        ### :page and :limit
                                        # Output:
                                        ## Collection of system languages supported by Lokalise
```

For example:

```ruby
params = {
  limit: 10,
  page: 3
}

languages = @client.system_languages params

languages[0].lang_name # => 'Abkhaz'
```

## Fetch project languages

[Doc](https://developers.lokalise.com/reference/list-project-languages)

```ruby
@client.project_languages(project_id, params = {})    # Input:
                                                      ## project_id (string, required)
                                                      ## params (hash)
                                                      ### :page and :limit
                                                      # Output:
                                                      ## Collection of languages available in the given project
```

For example:

```ruby
project_id = '123.abc'
params = {
  imit: 1,
  page: 2
}

languages = @client.project_languages project_id, params

languages[0].lang_iso # => 'fr'
```

Alternatively:

```ruby
project = @client.project project_id

languages = project.languages params
```

## Fetch a single project language

[Doc](https://developers.lokalise.com/reference/retrieve-a-language)

```ruby
@client.project_language(project_id, language_id) # Input:
                                                  ## project_id (string, required)
                                                  ## language_id (string, required)
                                                  # Output:
                                                  ## A single language in the given project
```

For example:

```ruby
project_id = '123.abc'
language_id = '1234'

language = client.project_language project_id, language_id

language.lang_iso # => 'fr'
```

Alternatively:

```ruby
project = @client.project project_id
language = project.language language_id
```

## Create project languages

[Doc](https://developers.lokalise.com/reference/create-languages)

```ruby
@client.create_project_languages(project_id, params)  # Input:
                                                      ## project_id (string, required)
                                                      ## params (array of hashes or hash, required) - contains parameter of newly created languages. Pass array of hashes to create multiple languages, or a hash to create a single language
                                                      ### :lang_iso (string, required)
                                                      ### :custom_iso (string)
                                                      ### :custom_name (string)
                                                      ### :custom_plural_forms (array) - can contain only plural forms initially supported by Lokalise
                                                      # Output:
                                                      ## Collection of newly created languages
```

For example:

```ruby
params = [{
  lang_iso: 'de'
}, {
  lang_iso: 'nl'
}]

languages = @client.create_project_languages project_id, params
languages[0].lang_iso # => 'de'
```

Alternatively:

```ruby
project = @client.project project_id
languages = project.create_languages params
```

## Update project language

[Doc](https://developers.lokalise.com/reference/update-a-language)

```ruby
@client.update_project_language(project_id, language_id, params)  # Input:
                                                                  ## project_id (string, required)
                                                                  ## language_id (string, required)
                                                                  ## params (hash, required)
                                                                  ### :lang_iso (string, required)
                                                                  ### :custom_name (string)
                                                                  ### :plural_forms (array) - can contain only plural forms initially supported by Lokalise
                                                                  # Output:
                                                                  ## Updated language
```

For example:

```ruby
params = {
  lang_name: 'Updated custom language',
  plural_forms: %w[one]
}

language = @client.update_project_language project_id, language_id, params
language.lang_name # => 'Updated custom language'
```

Alternatively:

```ruby
language = @client.project_language project_id, language_id
language.update params

# OR

project = @client.project project_id
language = @client.update_language language_id, params
```

## Delete project language

[Doc](https://developers.lokalise.com/reference/delete-a-language)

```ruby
@client.destroy_project_language(project_id, language_id) # Input:
                                                          ## project_id (string, required)
                                                          ## language_id (string, required)
                                                          # Output:
                                                          ## Generic with the project id and "language_deleted"=>true
```

For example:

```ruby
response = @client.destroy_project_language project_id, language_id
response.language_deleted # => true
```

Alternatively:

```ruby
language = @client.language project_id, language_id
response = language.destroy

# OR

project = @client.project project_id
response = project.destroy_language language_id
```