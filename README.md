# RubyLokaliseApi Client

[![Gem Version](https://badge.fury.io/rb/ruby-lokalise-api.svg)](https://badge.fury.io/rb/ruby-lokalise-api)
[![Build Status](https://travis-ci.org/lokalise/ruby-lokalise-api.svg?branch=master)](https://travis-ci.org/lokalise/ruby-lokalise-api)

Official Ruby interface for the [Lokalise API](https://lokalise.co/api2docs/ruby/).

## Getting Started

### Installation and Requirements

This gem requires [Ruby 2.4+](https://www.ruby-lang.org/en/) and [RubyGems package manager](https://rubygems.org/pages/download).

Install it by running:

```bash
$ gem install ruby-lokalise-api
```

### Initializing the Client

In order to perform API requests, you require a special token that can be obtained in your [personal profile](https://lokalise.co/profile#apitokens) (*API tokens* section). Note that the owner of the token must have admin access rights.

After you've obtained the token, initialize the client:

```ruby
require 'ruby-lokalise-api'

@client = Lokalise.client 'YOUR_TOKEN_HERE'
```

Now the `@client` can be used to perform API requests!

### Pagination

All collections returned by the API (that is, bulk fetches) support [pagination](https://lokalise.co/api2docs/php/#resource-pagination). There are two common parameters available:

* `:limit` (defaults to `100`, maximum is `5000`) - number of records to display per page
* `:page` (defaults  to `1`) - page to fetch

A paginated collection responds to the following methods:

* `#total_pages`
* `#total_results`
* `#results_per_page`
* `#current_page`

In order to fetch *the actual content of the collection*, use the `#content` method.

## Available Resources

### Comments

### Contributors

### Files

### Keys

### Languages

[Language attributes](https://lokalise.co/api2docs/ruby/#object-languages)

#### Fetch system languages

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-system-languages-get)

```ruby
@client.system_languages(params = {})   # Input:
                                        ## params (hash)
                                        ### :page and :limit
                                        # Output:
                                        ## Array of system languages supported by Lokalise
```

#### Fetch project languages

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-project-languages-get)

```ruby
@client.project_languages(project_id, params = {})    # Input:
                                                      ## project_id (string, required)
                                                      ## params (hash)
                                                      ### :page and :limit
                                                      # Output:
                                                      ## Array of languages available in the given project
```

#### Fetch a single project language

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-language-get)

```ruby
@client.language(project_id, language_id)     # Input:
                                              ## project_id (string, required)
                                              ## language_id (string, required)
                                              # Output:
                                              ## A single language in the given project
```

#### Create project languages

[Doc](https://lokalise.co/api2docs/ruby/#transition-create-languages-post)

```ruby
@client.create_language(project_id, params)     # Input:
                                                ## project_id (string, required)
                                                ## params (array or hash, required) - contains parameter of newly created languages. Pass array of hashes to create multiple languages, or a hash to create a single language
                                                ### :lang_iso (string, required)
                                                ### :custom_iso (string) 
                                                ### :custom_name (string)
                                                ### :custom_plural_forms (array) - can contain only plural forms initially supported by Lokalise
                                                # Output:
                                                ## Newly created language
```

#### Update project language

[Doc](https://lokalise.co/api2docs/ruby/#transition-update-a-language-put)

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

#### Delete project language

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-language-delete)

```ruby
@client.delete_language(project_id, language_id)     # Input:
                                                     ## project_id (string, required)
                                                     ## language_id (string, required)
                                                     # Output:
                                                     ## Hash with the project's id and "language_deleted"=>true
```

### Projects

[Project attributes](https://lokalise.co/api2docs/php/#object-projects)

#### Fetch projects collection

[Doc](https://lokalise.co/api2docs/php/#transition-list-all-projects-get)

```ruby
@client.projects(params = {})   # Input:
                                ## params (hash)
                                ### :filter_team_id (string) - load projects only for the given team
                                ### :page and :limit
                                # Output:
                                ## Array of projects under the `projects` attribute 
```

#### Fetch a single project

[Doc](https://lokalise.co/api2docs/php/#transition-retrieve-a-project-get)

```ruby
@client.project(project_id)     # Input:
                                ## project_id (string, required)
                                # Output:
                                ## A single project 
```

#### Create a project

[Doc](https://lokalise.co/api2docs/php/#transition-create-a-project-post)

```ruby
@client.create_project(params)  # Input:
                                ## params (hash, required)
                                ### name (string, required)
                                ### description (string)
                                ### team_id (integer) - you must be an admin of the chosen team. When omitted, defaults to the current team of the token's owner 
                                # Output:
                                ## A newly created project 

```

#### Update a project

[Doc](https://lokalise.co/api2docs/php/#transition-update-a-project-put)

```ruby
@client.update_project(project_id, params)  # Input:
                                            ## project_id (string, required)
                                            ## params (hash, required)
                                            ### name (string, required)
                                            ### description (string)
                                            # Output:
                                            ## An updated project
```

#### Empty a project

[Doc](https://lokalise.co/api2docs/php/#transition-empty-a-project-put)

Deletes *all* keys and translations from the project.

```ruby
@client.empty_project(project_id)   # Input:
                                    ## project_id (string, required)
                                    # Output:
                                    ## A project containing its id and a `keys_deleted => true` attribute
```

#### Delete a project

[Doc](https://lokalise.co/api2docs/php/#transition-delete-a-project-delete)

```ruby
@client.delete_project(project_id)    # Input:
                                      ## project_id (string, required)
                                      # Output:
                                      ## A project containing its id and a `project_deleted => true` attribute
```

### Screenshots

### Snapshots

### Tasks

### Teams

#### Fetch teams collection

[Doc](https://lokalise.co/api2docs/ruby/#resource-teams)

```ruby
@client.teams(params = {})  # Input:
                            ## params (hash)
                            ### :page and :limit
                            # Output:
                            ## Array of projects under the `projects` attribute 
```

### Team users

### Translations

## Additional Info

### Error handling

The gem may raise the following custom exceptions:

* `Lokalise::Error::BadRequest` - the provided token or an id is incorrect
* `Lokalise::Error::NotFound` - the provided endpoint (resource) cannot be found

### API Rate Limits

Lokalise does not [rate-limit API requests](https://lokalise.co/api2docs/ruby/#resource-rate-limits), however retain a right to decline the service in case of excessive use. Only one concurrent request per token is allowed. To ensure data consistency, it is not recommended to access the same project simultaneously using multiple tokens.

## Running Tests

1. Copypaste `.env.example` file as `.env`.
2. Put your API token inside. The `.env` file is excluded from version control so your token is safe.
3. Run `rspec .`. Observe test results and code coverage.

## License

This gem is licensed under the [MIT License](https://github.com/lokalise/ruby-lokalise-api/blob/master/LICENSE).

Copyright (c) [Lokalise team](http://lokalise.co), [Ilya Bodrov](http://bodrovis.tech)