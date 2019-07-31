# Lokalise API 2.0 official Ruby interface

[![Gem Version](https://badge.fury.io/rb/ruby-lokalise-api.svg)](https://badge.fury.io/rb/ruby-lokalise-api)
[![Build Status](https://travis-ci.org/lokalise/ruby-lokalise-api.svg?branch=master)](https://travis-ci.org/lokalise/ruby-lokalise-api)

Official opinionated Ruby interface for the [Lokalise API](https://lokalise.co/api2docs/ruby/) that represents returned data as Ruby objects.

## Index

* [Getting started](#getting-started)
  + [Installation and Requirements](#installation-and-requirements)
  + [Initializing the Client](#initializing-the-client)
  + [Objects and models](#objects-and-models)
  + [Collections of resources and pagination](#collections-of-resources-and-pagination)
* [Available Resources](#available-resources)
  + [Comments](#comments)
  + [Contributors](#contributors)
  + [Files](#files)
  + [Keys](#keys)
  + [Languages](#languages)
  + [Orders](#orders)
  + [Payment cards](#payment-cards)
  + [Projects](#projects)
  + [Screenshots](#screenshots)
  + [Snapshots](#snapshots)
  + [Tasks](#tasks)
  + [Teams](#teams)
  + [Team users](#team-users)
  + [Team user groups](#team-user-groups)
  + [Translations](#translations)
  + [Translation Providers](#translation-providers)
  + [Translation Statuses](#translation-statuses)
* [Additional Info](#additional-info)
  + [Customizing JSON parser](#customizing-json-parser)
  + [Error handling](#error-handling)
  + [API Rate Limits](#api-rate-limits)
* [Running Tests](#running-tests)

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

### Objects and models

Individual objects are represented as instances of Ruby classes which are called *models*. Each model responds to the methods that are named after the API object's attributes. [This file](https://github.com/lokalise/ruby-lokalise-api/blob/master/lib/ruby-lokalise-api/data/attributes.json) lists all objects and their methods.

Here is an example:

```ruby
project = client.project '123'
project.name
project.description
project.created_by
```

To get access to raw data returned by the API, use `#raw_data`:

```ruby
project.raw_data
```

Models support method chaining, meaning you can fetch a resource, update and delete it in one line:

```ruby
@client.project('123').update(name: 'New name').destroy
```

### Collections of resources and pagination

Fetching (or creating/updating) multiple objects will return a *collection* of objects. To get access to the actual data, use `#collection` method:

```ruby
project = @client.projects.collection.first # => Get the first project
project.name
```

Bulk fetches support [pagination](https://lokalise.co/api2docs/php/#resource-pagination). There are two common parameters available:

* `:limit` (defaults to `100`, maximum is `5000`) - number of records to display per page
* `:page` (defaults  to `1`) - page to fetch

```ruby
projects = @client.projects limit: 10, page: 3 #=> Paginate by 10 records and fetch the third page
```

Collections respond to the following methods:

* `#total_pages`
* `#total_results`
* `#results_per_page`
* `#current_page`
* `#next_page?`
* `#last_page?`
* `#prev_page?`
* `#first_page?`

For example:

```ruby
projects.current_page #=> 3
projects.last_page? #=> true, this is the last page and there are no more projects available
```

On top of that, you may easily fetch the next or the previous page of the collection by using:

* `#next_page`
* `#prev_page`

These methods return instances of the same collection class or `nil` if the next/previous page is unavailable. Methods respect the parameters you've initially passed:

```ruby
translations = @client.translations 'project_id', limit: 4, page: 2, disable_references: 0 # => we passed three parameters here

translations.prev_page # => will load the previous page while preserving the `limit` and `disable_references` params
```

## Available Resources

### Comments

[Comments attributes](https://lokalise.co/api2docs/ruby/#resource-comments)

#### Fetch project comments

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-project-comments-get)

```ruby
@client.project_comments(project_id, params = {})   # Input:
                                                    ## project_id (string, required)
                                                    ## params (hash)
                                                    ### :page and :limit
                                                    # Output:
                                                    ## Collection of comments available in the given project
```

#### Fetch key comments

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-key-comments-get)

```ruby
@client.comments(project_id, key_id, params = {})   # Input:
                                                    ## project_id (string, required)
                                                    ## key_id (string, required) 
                                                    ## params (hash)
                                                    ### :page and :limit
                                                    # Output:
                                                    ## Collection of comments available for the specified key in the given project
```

#### Create key comments

[Doc](https://lokalise.co/api2docs/ruby/#transition-create-comments-post)

```ruby
@client.create_comments(project_id, key_id, params)   # Input:
                                                      ## project_id (string, required)
                                                      ## key_id (string, required)  
                                                      ## params (array or hash, required) - contains parameter of newly created comments. Pass array of hashes to create multiple comments, or a hash to create a single comment
                                                      ### :comment (string, required)
                                                      # Output:
                                                      ## Newly created comment
```

#### Fetch key comment

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-comment-get)

```ruby
@client.comment(project_id, key_id, comment_id)   # Input:
                                                  ## project_id (string, required)
                                                  ## key_id (string, required) 
                                                  ## comment_id (string, required)  
                                                  # Output:
                                                  ## Comment for the key in the given project
```

#### Delete key comment

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-comment-delete)

```ruby
@client.destroy_comment(project_id, key_id, comment_id)   # Input:
                                                          ## project_id (string, required)
                                                          ## key_id (string, required) 
                                                          ## comment_id (string, required)  
                                                          # Output:
                                                          ## Hash with the project's id and "comment_deleted"=>true
```

Alternatively:

```ruby
comment = @client.comment('project_id', 'comment_id')
comment.destroy
```

### Contributors

#### Fetch contributors

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-contributors-get)

```ruby
@client.contributors(project_id, params = {})   # Input:
                                                ## project_id (string, required)
                                                ## params (hash)
                                                ### :page and :limit
                                                # Output:
                                                ## Collection of contributors in the given project
```

#### Fetch a single contributor

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-contributor-get)

```ruby
@client.contributor(project_id, contributor_id)   # Input:
                                                  ## project_id (string, required)
                                                  ## contributor_id (string, required) - named as "user_id" in the response
                                                  # Output:
                                                  ## Contributor in the given project
```

#### Create contributors

[Doc](https://lokalise.co/api2docs/ruby/#transition-create-contributors-post)

```ruby
@client.create_contributors(project_id, params)  # Input:
                                                 ## project_id (string, required)
                                                 ## params (array of hashes or hash, required) - parameters for the newly created contributors. Pass array of hashes to create multiple contributors, or a hash to create a single contributor
                                                 ### :email (string, required)
                                                 ### :fullname (string) 
                                                 ### :is_admin (boolean)
                                                 ### :is_reviewer (boolean)
                                                 ### :languages (array of hashes, required if "is_admin" set to false) - possible languages attributes:
                                                 #### :lang_iso (string, required)
                                                 #### :is_writable (boolean) 
                                                 ### :admin_rights (array) 
                                                 # Output:
                                                 ## Collection of newly created contributors
```

#### Update contributor

[Doc](https://lokalise.co/api2docs/ruby/#transition-update-a-contributor-put)

```ruby
@client.update_contributor(project_id, contributor_id, params)   # Input:
                                                                 ## project_id (string, required)
                                                                 ## contributor_id (string, required) 
                                                                 ## params (hash, required)
                                                                 ### :is_admin (boolean)
                                                                 ### :is_reviewer (boolean)
                                                                 ### :languages (array of hashes) - possible languages attributes:
                                                                 #### :lang_iso (string, required)
                                                                 #### :is_writable (boolean) 
                                                                 ### :admin_rights (array) 
                                                                 # Output:
                                                                 ## Updated contributor
```

Alternatively:

```ruby
contributor = @client.contributor('project_id', 'contributor_id')
contributor.update(params)
```

#### Delete contributor

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-contributor-delete)

```ruby
@client.destroy_contributor(project_id, contributor_id)    # Input:
                                                           ## project_id (string, required)
                                                           ## contributor_id (string, required)
                                                           # Output:
                                                           ## Hash with the project's id and "contributor_deleted"=>true
```

Alternatively:

```ruby
contributor = @client.contributor('project_id', 'id')
contributor.destroy
```

### Files

[File attributes](https://lokalise.co/api2docs/ruby/#object-files)

#### Fetch translation files

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-files-get)

```ruby
@client.files(project_id, params = {})  # Input:
                                        ## project_id (string, required)
                                        ## params (hash)
                                        ### :page and :limit
                                        # Output:
                                        ## Collection of translation files available in the given project
```

#### Download translation files

[Doc](https://lokalise.co/api2docs/ruby/#transition-download-files-post)

Exports project files as a `.zip` bundle and makes them available to download (the link is valid for 12 months).

```ruby
@client.download_files(project_id, params)  # Input:
                                        ## project_id (string, required)
                                        ## params (hash, required)
                                        ### :format (string, required) - one of the file formats supported by Lokalise (json, xml, po etc).
                                        ### Find the list of other supported params at https://lokalise.co/api2docs/ruby/#transition-download-files-post 
                                        # Output:
                                        ## Hash with the project id and a "bundle_url" link
```

#### Upload translation file

[Doc](https://lokalise.co/api2docs/ruby/#transition-upload-a-file-post)

```ruby
@client.upload_file(project_id, params) # Input:
                                        ## project_id (string, required)
                                        ## params (hash, required)
                                        ### :data (string, required) - base64-encoded data (the format must be supported by Lokalise)
                                        ### :filename (string, required)
                                        ### :lang_iso (string, required) 
                                        ### Find the list of other supported params at https://lokalise.co/api2docs/ruby/#transition-upload-a-file-post
                                        # Output:
                                        ## Hash with information about the upload
```

### Keys

[Key attributes](https://lokalise.co/api2docs/ruby/#object-keys)

#### Fetch project keys

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-keys-get)

```ruby
@client.keys(project_id, params = {})   # Input:
                                        ## project_id (string, required)
                                        ## params (hash)
                                        ### :page and :limit
                                        # Output:
                                        ## Collection of keys available in the given project
```

#### Fetch a single project key

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-key-get)

```ruby
@client.key(project_id, key_id, params = {})    # Input:
                                                ## project_id (string, required)
                                                ## key_id (string, required) 
                                                ## params (hash)
                                                ### :disable_references (string) - possible values are "1" and "0".
                                                # Output:
                                                ## Project key
```

#### Create project keys

[Doc](https://lokalise.co/api2docs/ruby/#transition-create-keys-post)

```ruby
@client.create_keys(project_id, params)   # Input:
                                          ## project_id (string, required)
                                          ## params (array of hashes or hash, required)
                                          ### :key_name (string or hash, required) - for projects with enabled per-platform key names, pass hash with "ios", "android", "web" and "other" params.
                                          ### :platforms (array) - supported values are "ios", "android", "web" and "other"
### Find all other supported attributes at https://lokalise.co/api2docs/ruby/#transition-create-keys-post 
                                          # Output:
                                          ## Collection of newly created keys
```

#### Update project key

[Doc](https://lokalise.co/api2docs/ruby/#transition-update-a-key-put)

```ruby
@client.update_key(project_id, key_id, params = {})   # Input:
                                                      ## project_id (string, required)
                                                      ## key_id (string, required)  
                                                      ## params (hash)
                                                      ### Find a list of supported attributes at https://lokalise.co/api2docs/ruby/#transition-update-a-key-put
                                                      # Output:
                                                      ## Updated key
```

Alternatively:

```ruby
key = @client.key('project_id', 'key_id')
key.update(params)
```

#### Bulk update project keys

[Doc](https://lokalise.co/api2docs/ruby/#transition-bulk-update-put)

```ruby
@client.update_keys(project_id, params)  # Input:
                                         ## project_id (string, required)
                                         ## params (hash or array of hashes, required)
                                         ### :key_id (string, required)
                                         ### Find all other supported attributes at https://lokalise.co/api2docs/ruby/#transition-bulk-update-put 
                                         # Output:
                                         ## Collection of updated keys
```

#### Delete project key

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-key-delete)

```ruby
@client.destroy_key(project_id, key_id) # Input:
                                        ## project_id (string, required)
                                        ## key_id (string, required)  
                                        # Output:
                                        ## Hash with project_id and "key_removed" set to "true"
```

Alternatively:

```ruby
key = @client.key('project_id', 'key_id')
key.destroy
```

#### Bulk delete project keys

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-multiple-keys-delete)

```ruby
@client.destroy_keys(project_id, key_ids) # Input:
                                          ## project_id (string, required)
                                          ## key_ids (array, required)  
                                          # Output:
                                          ## Hash with project_id and "keys_removed" set to "true"
```

Alternatively:

```ruby
keys = @client.keys('project_id')
keys.destroy_all # => will effectively destroy all keys in the project
```

### Languages

[Language attributes](https://lokalise.co/api2docs/ruby/#object-languages)

#### Fetch system languages

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-system-languages-get)

```ruby
@client.system_languages(params = {})   # Input:
                                        ## params (hash)
                                        ### :page and :limit
                                        # Output:
                                        ## Collection of system languages supported by Lokalise
```

#### Fetch project languages

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-project-languages-get)

```ruby
@client.project_languages(project_id, params = {})    # Input:
                                                      ## project_id (string, required)
                                                      ## params (hash)
                                                      ### :page and :limit
                                                      # Output:
                                                      ## Collection of languages available in the given project
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

Alternatively:

```ruby
language = @client.language('project_id', 'lang_id')
language.update(params)
```

#### Delete project language

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-language-delete)

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

### Orders

[Order attributes](https://lokalise.co/api2docs/curl/#object-orders)

#### Fetch order collection

[Doc](https://lokalise.co/api2docs/curl/#transition-list-all-orders-get)

```ruby
@client.orders(team_id, params = {})  # Input:
                                      ## team_id (integer, string, required)
                                      ## params (hash)
                                      ### :page and :limit
                                      # Output:
                                      ## Collection of orders for the given team
```

#### Fetch a single order

[Doc](https://lokalise.co/api2docs/curl/#transition-retrieve-an-order-get)

```ruby
@client.order(team_id, order_id)  # Input:
                                  ## team_id (string, integer, required)
                                  ## order_id (string, required)
                                  # Output:
                                  ## A single order
```

#### Create an order

[Doc](https://lokalise.co/api2docs/curl/#transition-create-an-order-post)

```ruby
@client.create_order(team_id, params)  # Input:
                                       ## team_id (string, integer, required)
                                       ## params (hash, required)
                                       ### project_id (string, required)
                                       ### card_id (integer, string, required) - card to process payment
                                       ### briefing (string, required)
                                       ### source_language_iso (string, required) 
                                       ### target_language_isos (array of strings, required)
                                       ### keys (array of integers, required) - keys to include in the order
                                       ### provider_slug (string, required)
                                       ### translation_tier (integer, required) 
                                       ### dry_run (boolean) - return the response without actually placing an order. Useful for price estimation. Default is `false`
                                       ### translation_style (string) - only for gengo provider. Available values are `formal`, `informal`, `business`, `friendly`. Defaults to `friendly`. 
                                       # Output:
                                       ## A newly created order

```

### Payment cards

[Payment card attributes](https://lokalise.co/api2docs/ruby/#object-payment-cards)

#### Fetch payment card collection

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-cards-get)

```ruby
@client.payment_cards(params = {})    # Input:
                                      ## params (hash)
                                      ### :page and :limit
                                      # Output:
                                      ## Collection of payment cards under the `payment_cards` attribute 
```

#### Fetch a single payment card

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-card-get)

```ruby
@client.payment_card(card_id)     # Input:
                                  ## card_id (string, required)
                                  # Output:
                                  ## A single payment card
```

#### Create a payment card

[Doc](https://lokalise.co/api2docs/ruby/#transition-create-a-card-post)

```ruby
@client.create_payment_card(params)   # Input:
                                      ## params (hash, required)
                                      ### number (integer, string, required) - card number
                                      ### cvc (integer, required) - 3-digit card CVV (CVC)
                                      ### exp_month (integer, required) - card expiration month (1 - 12)
                                      ### exp_year (integer, required) - card expiration year (for example, 2019)
                                      # Output:
                                      ## A newly created payment card 

```

#### Delete a payment card

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-card-delete)

```ruby
@client.destroy_payment_card(card_id)   # Input:
                                        ## card_id (integer, string, required)
                                        # Output:
                                        ## Hash containing card id and `card_deleted => true` attribute
```

Alternatively:

```ruby
card = @client.payment_card('card_id')
card.destroy
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
                                ## Collection of projects under the `projects` attribute 
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

Alternatively:

```ruby
project = @client.project('project_id')
project.update(params)
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

Alternatively:

```ruby
project = @client.project('project_id')
project.empty
```

#### Delete a project

[Doc](https://lokalise.co/api2docs/php/#transition-delete-a-project-delete)

```ruby
@client.destroy_project(project_id)   # Input:
                                      ## project_id (string, required)
                                      # Output:
                                      ## A project containing its id and a `project_deleted => true` attribute
```

Alternatively:

```ruby
project = @client.project('project_id')
project.destroy
```

### Screenshots

[Screenshot attributes](https://lokalise.co/api2docs/ruby/#resource-screenshots)

#### Fetch screenshots

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-screenshots-get)

```ruby
@client.screenshots(project_id, params = {})  # Input:
                                              ## project_id (string, required)
                                              ## params (hash)
                                              ### :page and :limit
                                              # Output:
                                              ## Collection of project screenshots
```

#### Fetch a single screenshot

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-screenshot-get)

```ruby
@client.screeshot(project_id, screeshot_id)     # Input:
                                                ## project_id (string, required)
                                                ## screeshot_id (string, required)
                                                # Output:
                                                ## A single screenshot 
```

#### Create screenshots

[Doc](https://lokalise.co/api2docs/ruby/#transition-create-screenshots-post)

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

#### Update screenshot

[Doc](https://lokalise.co/api2docs/ruby/#transition-update-a-screenshot-put)

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

#### Delete screenshot

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-screenshot-delete)

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

### Snapshots

[Snapshot attributes](https://lokalise.co/api2docs/ruby/#object-snapshots)

#### Fetch snapshots

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-snapshots-get)

```ruby
@client.snapshots(project_id, params = {})  # Input:
                                            ## project_id (string, required)
                                            ## params (hash)
                                            ### :filter_title (string) - set title filter for the list 
                                            ### :page and :limit
                                            # Output:
                                            ## Collection of project snapshots
```

#### Create snapshot

[Doc](https://lokalise.co/api2docs/ruby/#transition-create-a-snapshot-post)

```ruby
@client.create_snapshot(project_id, params = {})  # Input:
                                                  ## project_id (string, required)
                                                  ## params (hash)
                                                  ### :title (string)
                                                  # Output:
                                                  ## Created snapshot
```

#### Restore snapshot

[Doc](https://lokalise.co/api2docs/ruby/#transition-restore-a-snapshot-post)

```ruby
@client.restore_snapshot(project_id, snapshot_id)   # Input:
                                                    ## project_id (string, required)
                                                    ## snapshot_id (string, required)
                                                    # Output:
                                                    ## Information about the restored project from the specified snapshot
```

Alternatively:

```ruby
snapshot = @client.snapshots('project_id').first # you can't fetch a single snapshot
snapshot.restore
```

#### Delete snapshot

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-snapshot-delete)

```ruby
@client.destroy_snapshot(project_id, snapshot_id)   # Input:
                                                    ## project_id (string, required)
                                                    ## snapshot_id (string, required)
                                                    # Output:
                                                    ## Hash with the project id and "snapshot_deleted" set to "true"
```

Alternatively:

```ruby
snapshot = @client.snapshots('project_id').first # you can't fetch a single snapshot
snapshot.destroy
```

### Tasks

[Task attributes](https://lokalise.co/api2docs/ruby/#resource-tasks)

#### Fetch tasks

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-tasks-get)

```ruby
@client.tasks(project_id, params = {})  # Input:
                                        ## project_id (string, required)
                                        ## params (hash)
                                        ### :filter_title (string) - set title filter for the list 
                                        ### :page and :limit
                                        # Output:
                                        ## Collection of tasks for the project
```

#### Fetch a single task

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-task-get)

```ruby
@client.task(project_id, task_id, params = {})  # Input:
                                                ## project_id (string, required)
                                                ## task_id (string, required)
                                                # Output:
                                                ## Single task for the project
```

#### Create task

[Doc](https://lokalise.co/api2docs/ruby/#transition-create-a-task-post)

```ruby
@client.create_task(project_id, params)  # Input:
                                         ## project_id (string, required)
                                         ## params (hash, required)
                                         ### title (string, required)
                                         ### keys (array) - translation key ids. Required if "parent_task_id" is not specified 
                                         ### languages (array of hashes, required)
                                         #### language_iso (string)
                                         #### users (array) - list of users identifiers, assigned to work on the language 
                                         ### Find other supported options at https://lokalise.co/api2docs/ruby/#transition-create-a-task-post 
                                         # Output:
                                         ## A newly created task 

```

#### Update task

[Doc](https://lokalise.co/api2docs/ruby/#transition-update-a-task-put)

```ruby
@client.update_task(project_id, task_id, params = {})  # Input:
                                                       ## project_id (string, required)
                                                       ## task_id (string or integer, required) 
                                                       ## params (hash)
                                                       ### Find supported params at https://lokalise.co/api2docs/ruby/#transition-update-a-task-put 
                                                       # Output:
                                                       ## An updated task 

```

Alternatively:

```ruby
task = @client.task('project_id', 'task_id')
task.update(params)
```

#### Delete task

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-task-delete)

```ruby
@client.destroy_task(project_id, task_id)  # Input:
                                           ## project_id (string, required)
                                           ## task_id (string, required) 
                                           # Output:
                                           ## Hash with the project id and "task_deleted" set to "true"

```

Alternatively:

```ruby
task = @client.task('project_id', 'task_id')
task.destroy
```

### Teams

#### Fetch teams

[Doc](https://lokalise.co/api2docs/ruby/#resource-teams)

```ruby
@client.teams(params = {})  # Input:
                            ## params (hash)
                            ### :page and :limit
                            # Output:
                            ## Collection of teams
```

### Team users

[Team user attributes](https://lokalise.co/api2docs/ruby/#object-team-users)

#### Fetch team users

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-team-users-get)

```ruby
@client.team_users(team_id, params = {})  # Input:
                                          ## team_id (string, required)
                                          ## params (hash)
                                          ### :page and :limit
                                          # Output:
                                          ## Collection of team users
```

#### Fetch a single team user

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-team-user-get)

```ruby
@client.team_user(team_id, user_id) # Input:
                                    ## team_id (string, required)
                                    ## user_id (string, required)
                                    # Output:
                                    ## Team user
```

#### Update team user

[Doc](https://lokalise.co/api2docs/ruby/#transition-update-a-team-user-put)

```ruby
@client.update_team_user(team_id, user_id, params)  # Input:
                                                    ## team_id (string, required)
                                                    ## user_id (string, required)
                                                    ## params (hash, required):
                                                    ### :role (string, required) - :owner, :admin, or :member 
                                                    # Output:
                                                    ## Updated team user
```

Alternatively:

```ruby
user = @client.team_user('team_id', 'user_id')
user.update(params)
```

#### Delete team user

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-team-user-delete)

```ruby
@client.destroy_team_user(team_id, user_id) # Input:
                                            ## team_id (string, required)
                                            ## user_id (string, required)
                                            # Output:
                                            ## Hash with "team_id" and "team_user_deleted" set to "true"
```

Alternatively:

```ruby
user = @client.team_user('team_id', 'user_id')
user.destroy
```

### Team user groups

[Team user group attributes](https://lokalise.co/api2docs/ruby/#object-team-user-groups)

#### Fetch team user groups

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-groups-get)

```ruby
@client.team_user_groups(team_id, params = {})  # Input:
                                                ## team_id (string, required)
                                                ## params (hash)
                                                ### :page and :limit
                                                # Output:
                                                ## Collection of team user groups
```

#### Fetch a single group

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-group-get)

```ruby
@client.team_user_group(team_id, group_id)  # Input:
                                            ## team_id (string, required)
                                            ## group_id (string, required)
                                            # Output:
                                            ## Group
```

#### Create group

[Doc](https://lokalise.co/api2docs/ruby/#transition-create-a-group-post)

```ruby
@client.create_team_user_group(team_id, params) # Input:
                                                ## team_id (string, required)
                                                ## params (hash, required):
                                                ### :name (string, required)
                                                ### :is_reviewer (boolean, required)
                                                ### :is_admin (boolean, required)
                                                ### :admin_rights (array) - required only if is_admin is true
                                                ### :languages (array of hashes) - required if is_admin is false
                                                # Output:
                                                ## Updated group
```

#### Update group

[Doc](https://lokalise.co/api2docs/ruby/#transition-update-a-group-put)

```ruby
@client.update_team_user_group(team_id, group_id, params) # Input:
                                                          ## team_id (string, required)
                                                          ## group_id (string, required)
                                                          ## params (hash, required):
                                                          ### :name (string, required)
                                                          ### :is_reviewer (boolean, required)
                                                          ### :is_admin (boolean, required)
                                                          ### :admin_rights (array) - required only if is_admin is true
                                                          ### :languages (array of hashes) - required if is_admin is false
                                                          # Output:
                                                          ## Updated group
```

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.update(params)
```

#### Add projects to group

[Doc](https://lokalise.co/api2docs/ruby/#transition-add-projects-to-group-put)

```ruby
@client.add_projects_to_group(team_id, group_id, project_ids) # Input:
                                                              ## team_id (string, required)
                                                              ## group_id (string, required)
                                                              ## project_ids (string or array, required) - project ids that you would like to add to this group
```

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.add_projects projects: [project_id1, project_id2]
```

#### Remove projects from group

[Doc](https://lokalise.co/api2docs/ruby/#transition-remove-projects-from-group-put)

```ruby
@client.remove_projects_from_group(team_id, group_id, project_ids)  # Input:
                                                                    ## team_id (string, required)
                                                                    ## group_id (string, required)
                                                                    ## project_ids (string or array, required) - project ids that you would like to remove from this group
```

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.remove_projects projects: [project_id1, project_id2]
```

#### Add users (members) to group

[Doc](https://lokalise.co/api2docs/ruby/#transition-add-members-to-group-put)

```ruby
@client.add_users_to_group(team_id, group_id, user_ids) # Input:
                                                        ## team_id (string, required)
                                                        ## group_id (string, required)
                                                        ## user_ids (string or array, required) - user ids that you would like to add to this group
```

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.add_users users: [user_id1, user_id2]
```

#### Remove users (members) from group

[Doc](https://lokalise.co/api2docs/ruby/#transition-remove-members-from-group-put)

```ruby
@client.remove_users_from_group(team_id, group_id, user_ids)  # Input:
                                                              ## team_id (string, required)
                                                              ## group_id (string, required)
                                                              ## user_ids (string or array, required) - user ids that you would like to add to this group
```

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.remove_users users: [user_id1, user_id2]
```

#### Destroy group

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-group-delete)

```ruby
@client.destroy_team_user_group(team_id, group_id)  # Input:
                                                    ## team_id (string, required)
                                                    ## group_id (string, required)
                                                    # Output:
                                                    ## Hash with "team_id" and "group_deleted" set to "true"
```

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.destroy
```

### Translations

[Translation attributes](https://lokalise.co/api2docs/ruby/#resource-translations)

#### Fetch translations

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-translations-get)

```ruby
@client.translations(project_id, params = {})   # Input:
                                                ## project_id (string, required)
                                                ## params (hash)
                                                ### Find full list in the docs
                                                ### :page and :limit
                                                # Output:
                                                ## Collection of translations for the project
```

#### Fetch a single translation

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-translation-get)

```ruby
@client.translation(project_id, translation_id, params = {})   # Input:
                                                                ## project_id (string, required)
                                                                ## translation_id (string, required) 
                                                                ## params (hash)
                                                                ### :disable_references (string) - whether to disable key references. Supported values are 0 and 1
                                                                # Output:
                                                                ## Single translation for the project
```

#### Update translation

[Doc](https://lokalise.co/api2docs/ruby/#transition-update-a-translation-put)

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

### Translation Providers

[Translation provider attributes](https://lokalise.co/api2docs/ruby/#object-translation-providers)

#### Fetch translations

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-providers-get)

```ruby
@client.translation_providers(team_id, params = {})   # Input:
                                                      ## team_id (string, required)
                                                      ## params (hash)
                                                      ### :page and :limit
                                                      # Output:
                                                      ## Collection of providers for the team
```

#### Fetch a single translation

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-provider-get)

```ruby
@client.translation_provider(team_id, provider_id)  # Input:
                                                    ## team_id (string, required)
                                                    ## provider_id (string, required) 
                                                    # Output:
                                                    ## Single provider for the team
```

### Translation Statuses

[Translation Status attributes](https://lokalise.co/api2docs/ruby/#object-translation-statuses)

*Custom translation statuses must be enabled for the project before using this endpoint!* It can be done in the project settings.

#### Fetch translation statuses

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-custom-translation-statuses-get)

```ruby
@client.translation_statuses(project_id, params = {}) # Input:
                                                      ## project_id (string, required)
                                                      ## params (hash)
                                                      ### :page and :limit
                                                      # Output:
                                                      ## Collection of translation statuses for the project
```

#### Fetch a single translation status

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-custom-translation-status-get)

```ruby
@client.translation_status(project_id, status_id) # Input:
                                                  ## project_id (string, required)
                                                  ## status_id (string or integer, required)
                                                  # Output:
                                                  ## Translation status inside the given project
```

#### Create translation status

[Doc](https://lokalise.co/api2docs/ruby/#transition-create-a-custom-translation-status-post)

```ruby
@client.create_translation_status(project_id, params) # Input:
                                                      ## project_id (string, required)
                                                      ## params (hash, required)
                                                      ### :title (string, required) - title of the new status
                                                      ### :color (string, required) - HEX color code of the new status. Lokalise allows a very limited number of color codes to set. Check the official docs or use `#translation_status_colors` method listed below to find the list of supported colors
                                                      # Output:
                                                      ## Created translation status
```

#### Update translation status

[Doc](https://lokalise.co/api2docs/ruby/#transition-update-a-custom-translation-status-put)

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

#### Delete translation status

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-custom-translation-status-delete)

```ruby
@client.destroy_translation_status(project_id, status_id) # Input:
                                                          ## project_id (string, required)
                                                          ## status_id (string or integer, required)
                                                          # Output:
                                                          ## Translation status inside the given project
```

Alternatively:

```ruby
status = @client.translation_status(project_id, status_id)
status.destroy
```

#### Supported color codes for translation statuses

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-available-colors-for-custom-translation-statuses-get)

As long as Lokalise supports only very limited array of color hexadecimal codes for custom translation statuses, this method can be used to fetch all permitted values.

```ruby
@client.translation_status_colors(project_id) # Input:
                                              ## project_id (string, required)
                                              # Output:
                                              ## Array of color codes in HEX format
```

## Additional Info

### Customizing JSON parser

This gem used to rely on [MultiJson](https://github.com/intridea/multi_json) but it is not maintained anymore. By default we are using a [built-in JSON module](https://ruby-doc.org/stdlib-2.0.0/libdoc/json/rdoc/JSON.html) but you may utilize any other parser by overriding `#custom_dump` and `#custom_load` methods inside `Lokalise::JsonHandler` module.

For example, to use [Oj](https://github.com/ohler55/oj) you would do the following:

```ruby
require 'oj'

module Lokalise
  module JsonHandler  
    # This method accepts a Ruby object and must return a JSON string
    def custom_dump(obj)
      Oj.dump obj
    end

    # This method accepts JSON and must return Ruby object
    def custom_load(obj)
      Oj.load obj
    end
  end
end
```

### Error handling

[Error codes](https://lokalise.co/api2docs/curl/#resource-errors)

The gem may raise the following custom exceptions:

* `Lokalise::Error::BadRequest` (`400`) - the provided request incorrect
* `Lokalise::Error::Unauthorized` (`401`) - token is missing or incorrect
* `Lokalise::Error::Forbidden` (`403`) - authenticated user does not have sufficient rights to perform the desired action
* `Lokalise::Error::NotFound` (`404`) - the provided endpoint (resource) cannot be found
* `Lokalise::Error::MethodNowAllowed` (`405`) - HTTP request with the provided verb is not supported by the endpoint
* `Lokalise::Error::NotAcceptable` (`406`) - posted resource is malformed
* `Lokalise::Error::Conflict` (`409`) - request conflicts with another request
* `Lokalise::Error::Locked` (`423`) - your token is used simultaneously in multiple requests
* `Lokalise::Error::TooManyRequests` (`429`)
* `Lokalise::Error::ServerError` (`500`)
* `Lokalise::Error::BadGateway` (`502`)
* `Lokalise::Error::ServiceUnavailable` (`503`)
* `Lokalise::Error::GatewayTimeout` (`504`)

### API Rate Limits

Lokalise does not [rate-limit API requests](https://lokalise.co/api2docs/ruby/#resource-rate-limits), however retain a right to decline the service in case of excessive use. Only one concurrent request per token is allowed. To ensure data consistency, it is not recommended to access the same project simultaneously using multiple tokens.

## Running Tests

1. Copypaste `.env.example` file as `.env`. Put your API token inside. The `.env` file is excluded from version control so your token is safe. All in all, we use pre-recorded VCR cassettes, so the actual API requests won't be sent. However, providing at least some token is required.
3. Run `rspec .`. Observe test results and code coverage.

## License

This gem is licensed under the [MIT License](https://github.com/lokalise/ruby-lokalise-api/blob/master/LICENSE).

Copyright (c) [Lokalise team](http://lokalise.co), [Ilya Bodrov](http://bodrovis.tech)
