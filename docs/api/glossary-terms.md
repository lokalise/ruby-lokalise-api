# Glossary terms

## List glossary terms

[API doc](https://developers.lokalise.com/reference/list-glossary-terms)

```ruby
@client.glossary_terms(project_id, params = {})   # Input:
                                                  ## project_id (string, required)
                                                  ## params (hash)
                                                  ### :cursor and :limit
                                                  # Output:
                                                  ## Collection of glossary terms in the given project
```

For example:

```ruby
cursor_params = {
  limit: 2,
  cursor: '5319746'
}

glossary_terms = @client.glossary_terms project_id, cursor_params

glossary_terms.next_cursor # => 12345

glossary_term = glossary_terms[0]

glossary_term.term # => 'sample'
```

## Fetch a glossary term

[API doc](https://developers.lokalise.com/reference/retrieve-a-glossary-term)

```ruby
@client.glossary_term(project_id, term_id)  # Input:
                                            ## project_id (string, required)
                                            ## term_id (string or number, required)
                                            # Output:
                                            ## Glossary term resource
```

For example:

```ruby
glossary_term = @client.glossary_term project_id, 1234

glossary_term.term # => 'router'
glossary_term.description # => 'A network device'
```

## Create glossary terms

[API doc](https://developers.lokalise.com/reference/create-glossary-terms)

```ruby
@client.create_glossary_terms(project_id, params)   # Input:
                                                    ## project_id (string, required)
                                                    ## params (array of hashes or hash, required)
                                                    # Output:
                                                    ## Collection of newly created terms
```

For example:

```ruby
terms_data = [
  {
    term: 'term 1',
    description: 'my term',
    caseSensitive: false,
    translatable: false,
    forbidden: false
  },
  {
    term: 'term 2',
    description: 'my term 2',
    caseSensitive: true,
    translatable: true,
    forbidden: false
  }
]

glossary_terms = @client.create_glossary_terms project_id, terms_data

term = glossary_terms[0]

expect(term.description).to eq('my term')
```

## Update glossary terms

[API doc](https://developers.lokalise.com/reference/update-glossary-terms)

```ruby
@client.update_glossary_terms(project_id, params)   # Input:
                                                    ## project_id (string, required)
                                                    ## params (hash or array of hashes, required)
                                                    # Output:
                                                    ## Collection of updated keys
```

For example:

```ruby
terms_data = [
  {
    id: 5_517_075,
    term: 'updated term'
  },
  {
    id: 5_517_076,
    description: 'updated desc'
  }
]

glossary_terms = @client.update_glossary_terms project_id, terms_data

glossary_term = glossary_terms[0]

expect(glossary_term.term).to eq('updated term')
```

## Delete glossary terms

[API doc](https://developers.lokalise.com/reference/delete-glossary-terms)

```ruby
@client.destroy_glossary_terms(project_id, term_ids)  # Input:
                                                      ## project_id (string, required)
                                                      ## term_ids (array, required)
                                                      # Output:
                                                      ## Generic with deletion information
```

For example:

```ruby
term_ids = %w[5517075 5517076]

resp = @client.destroy_glossary_terms project_id, term_ids

resp.data['deleted']['count'] # => 2
```