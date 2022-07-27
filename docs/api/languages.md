# Languages

[Language attributes](https://app.lokalise.com/api2docs/curl/#object-languages)

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
@client.system_languages limit: 10, page: 3
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
@client.project_languages project_id, limit: 1, page: 2
```

## Fetch a single project language

[Doc](https://developers.lokalise.com/reference/retrieve-a-language)

```ruby
@client.language(project_id, language_id)     # Input:
                                              ## project_id (string, required)
                                              ## language_id (string, required)
                                              # Output:
                                              ## A single language in the given project
```

## Create project languages

[Doc](https://developers.lokalise.com/reference/create-languages)

```ruby
@client.create_languages(project_id, params)    # Input:
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
@client.create_languages project_id, lang_iso: 'ab', custom_name: 'Demo lang'
```

## Update project language

[Doc](https://developers.lokalise.com/reference/update-a-language)

```ruby
@client.update_language(project_id, language_id, params)    # Input:
                                                            ## project_id (string, required)
                                                            ## language_id (string, required)
                                                            ## params (hash, required)
                                                            ### :lang_iso (string, required)
                                                            ### :custom_name (string)
                                                            ### :plural_forms (array) - can contain only plural forms initially supported by Lokalise
                                                            # Output:
                                                            ## Updated language
```

Alternatively:

```ruby
language = @client.language('project_id', 'lang_id')
language.update(params)
```

For example:

```ruby
@client.update_language project_id, new_language_id,
                        lang_name: 'Updated custom language',
                        plural_forms: %w[one]
```

## Delete project language

[Doc](https://developers.lokalise.com/reference/delete-a-language)

```ruby
@client.destroy_language(project_id, language_id)    # Input:
                                                     ## project_id (string, required)
                                                     ## language_id (string, required)
                                                     # Output:
                                                     ## Hash with the project's id and "language_deleted"=>true
```

Alternatively:

```ruby
language = @client.language('project_id', 'lang_id')
language.destroy
```
