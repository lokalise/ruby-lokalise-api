---
---
# Segments

## Fetch segments

[Doc](https://developers.lokalise.com/reference/list-all-segments-for-key-language)

```ruby
@client.segments(project_id, key_id, lang_iso, params = {})   # Input:
                                                              ## project_id (string, required)
                                                              ## key_id (integer or string, required)
                                                              ## lang_iso (string, required)
                                                              ## params (hash)
                                                              ### :disable_references (string, default "0") — whether to disable key references. Possible values are 1 and 0.
                                                              ### :filter_is_reviewed (string, default "0") — Filter translations which are reviewed. Possible values are 1 and 0.
                                                              ### :filter_unverified (string, default "0") — Filter translations which are unverified (fuzzy). Possible values are 1 and 0.
                                                              ### :filter_untranslated (string, default "0") — Filter by untranslated keys. Possible values are 1 and 0.
                                                              ### :filter_qa_issues (string) — One or more QA issues to filter by (comma separated).
                                                              ### :page and :limit
                                                              # Output:
                                                              ## Collection of segments
```

For example:

```ruby
project_id = '123.abc'
key_id = 1234
language_iso = 'en'
params = {
  disable_references: 1
}

segments = @client.segments project_id, key_id, language_iso, params

segments[0].segment_number # => 1
```

Alternatively:

```ruby
project = @client.project project_id
segments = project.segments key_id, language_iso, params
```

## Fetch a single segment

[Doc](https://developers.lokalise.com/reference/retrieve-a-segment-for-key-language)

```ruby
@client.segment(project_id, key_id, lang_iso, segment_number, params = {})  # Input:
                                                                            ## project_id (string, required)
                                                                            ## key_id (integer or string, required)
                                                                            ## lang_iso (string, required)
                                                                            ## segment_number (integer or string, required)
                                                                            ## params (hash)
                                                                            ### :disable_references (string, default "0") — whether to disable key references. Possible values are 1 and 0.
```

For example:

```ruby
project_id = '123.abc'
key_id = 1234
language_iso = 'en'
segment_number = 1

segment = @client.segment project_id, key_id, language_iso, segment_number, params

segment.segment_number # => 1
segment.value # => 'My text.'
```

Alternatively:

```ruby
project = @client.project project_id

segment = project.segment key_id, language_iso, segment_number, params
```

## Update segment

[Doc](https://developers.lokalise.com/reference/update-a-segment)

```ruby
@client.update_segment(project_id, key_id, lang_iso, segment_number, params = {}) # Input:
                                                                                  ## project_id (string, required)
                                                                                  ## key_id (integer or string, required)
                                                                                  ## lang_iso (string, required)
                                                                                  ## segment_number (integer or string, required)
                                                                                  ## params (hash)
                                                                                  ### :value (string, required) — The actual translation content. Use an JSON object for plural keys.
                                                                                  ### :is_fuzzy (boolean) — Whether the Fuzzy flag is enabled. (Note: Fuzzy is called Unverified in the editor now).
                                                                                  ### :is_reviewed (boolean) — Whether the Reviewed flag is enabled.
                                                                                  ### :custom_translation_status_ids (array of strings or integers) — Custom translation status IDs to assign to translation (existing statuses will be replaced).
```

For example:

```ruby
project_id = '123.abc'
key_id = 1234
language_iso = 'en'
segment_number = 1
params = {
  value: 'Updated.',
  is_fuzzy: false
}

segment = @client.update_segment project_id, key_id, language_iso, segment_number, params

segment.is_fuzzy # => false
segment.value # => 'Updated.'
```

Alternatively:

```ruby
segment = @client.segment project_id, key_id, language_iso, segment_number
segment.update params

# OR

project = @client.project project_id
segment = project.update_segment key_id, language_iso, segment_number, params
```