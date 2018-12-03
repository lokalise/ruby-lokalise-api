# RubyLokaliseApi Client

[![Gem Version](https://badge.fury.io/rb/ruby-lokalise-api.svg)](https://badge.fury.io/rb/ruby-lokalise-api)
[![Build Status](https://travis-ci.org/lokalise/ruby-lokalise-api.svg?branch=master)](https://travis-ci.org/lokalise/ruby-lokalise-api)

Official Ruby interface for the [Lokalise API](https://lokalise.co/api2docs/ruby/).

## Index

* [Getting started](#getting-started)
  + [Installation and Requirements](#installation-and-requirements)
  + [Initializing the Client](#initializing-the-client)
  + [Pagination](#pagination)
* [Available Resources](#available-resources)
  + [Comments](#comments)
  + [Contributors](#contributors)
  + [Files](#files)
  + [Keys](#keys)
  + [Languages](#languages)
  + [Projects](#projects)
  + [Screenshots](#screenshots)
  + [Snapshots](#snapshots)
  + [Tasks](#tasks)
  + [Teams](#teams)
  + [Team users](#team-users)
  + [Translations](#translations)
* [Additional Info](#additional-info)
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

[Comments attributes](https://lokalise.co/api2docs/ruby/#resource-comments)

#### Fetch project comments

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-project-comments-get)

```ruby
@client.project_comments(project_id, params = {})   # Input:
                                                    ## project_id (string, required)
                                                    ## params (hash)
                                                    ### :page and :limit
                                                    # Output:
                                                    ## Array of comments available in the given project
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
                                                    ## Array of comments available for the specified key in the given project
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
@client.delete_comment(project_id, key_id, comment_id)    # Input:
                                                          ## project_id (string, required)
                                                          ## key_id (string, required) 
                                                          ## comment_id (string, required)  
                                                          # Output:
                                                          ## Hash with the project's id and "comment_deleted"=>true
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
                                                ## Array of contributors in the given project
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
                                                 ## params (array or hash, required) - parameters for the newly created contributors. Pass array of hashes to create multiple contributors, or a hash to create a single contributor
                                                 ### :email (string, required)
                                                 ### :fullname (string) 
                                                 ### :is_admin (boolean)
                                                 ### :is_reviewer (boolean)
                                                 ### :languages (array of hashes, required if "is_admin" set to false) - possible languages attributes:
                                                 #### :lang_iso (string, required)
                                                 #### :is_writable (boolean) 
                                                 ### :admin_rights (array) 
                                                 # Output:
                                                 ## Newly created contributor
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

#### Delete contributor

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-contributor-delete)

```ruby
@client.delete_contributor(project_id, contributor_id)     # Input:
                                                           ## project_id (string, required)
                                                           ## contributor_id (string, required)
                                                           # Output:
                                                           ## Hash with the project's id and "contributor_deleted"=>true
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
                                        ## Array of translation files available in the given project
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
                                        ## Array of keys available in the given project
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
                                          ## Newly created keys
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

#### Bulk update project keys

[Doc](https://lokalise.co/api2docs/ruby/#transition-bulk-update-put)

```ruby
@client.update_keys(project_id, params)  # Input:
                                         ## project_id (string, required)
                                         ## params (hash or array of hashes, required)
                                         ### :key_id (string, required)
                                         ### Find all other supported attributes at https://lokalise.co/api2docs/ruby/#transition-bulk-update-put 
                                         # Output:
                                         ## Updated keys
```

#### Delete project key

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-key-delete)

```ruby
@client.delete_key(project_id, key_id)  # Input:
                                        ## project_id (string, required)
                                        ## key_id (string, required)  
                                        # Output:
                                        ## Hash with project_id and "key_removed" set to "true"
```

#### Bulk delete project keys

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-multiple-keys-delete)

```ruby
@client.delete_keys(project_id, key_ids)  # Input:
                                          ## project_id (string, required)
                                          ## key_ids (array, required)  
                                          # Output:
                                          ## Hash with project_id and "keys_removed" set to "true"
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
@client.create_languages(project_id, params)    # Input:
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

[Screenshot attributes](https://lokalise.co/api2docs/ruby/#resource-screenshots)

#### Fetch screenshots

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-screenshots-get)

```ruby
@client.screenshots(project_id, params = {})  # Input:
                                              ## project_id (string, required)
                                              ## params (hash)
                                              ### :page and :limit
                                              # Output:
                                              ## Array of project screenshots
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
                                                   ## Created screenshots
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
                                                                  ## Created screenshots
```

#### Delete screenshot

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-screenshot-delete)

```ruby
@client.delete_screenshot(project_id, screenshot_id)    # Input:
                                                        ## project_id (string, required)
                                                        ## screenshot_id (string, required)
                                                        # Output:
                                                        ## Hash with the project id and "screenshot_deleted" set to "true"
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
                                            ## Array of project snapshots
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

#### Delete snapshot

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-snapshot-delete)

```ruby
@client.delete_snapshot(project_id, snapshot_id)    # Input:
                                                    ## project_id (string, required)
                                                    ## snapshot_id (string, required)
                                                    # Output:
                                                    ## Hash with the project id and "snapshot_deleted" set to "true"
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
                                        ## Array of tasks for the project
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
@client.delete_task(project_id, task_id)   # Input:
                                           ## project_id (string, required)
                                           ## task_id (string, required) 
                                           # Output:
                                           ## Hash with the project id and "task_deleted" set to "true"

```

### Teams

#### Fetch teams

[Doc](https://lokalise.co/api2docs/ruby/#resource-teams)

```ruby
@client.teams(params = {})  # Input:
                            ## params (hash)
                            ### :page and :limit
                            # Output:
                            ## Array of projects under the `projects` attribute 
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
                                          ## Array of team users
```

#### Fetch a single team user

[Doc](https://lokalise.co/api2docs/ruby/#transition-retrieve-a-team-user-get)

```ruby
@client.team_user(team_id, user_id)  # Input:
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

#### Delete team user

[Doc](https://lokalise.co/api2docs/ruby/#transition-delete-a-team-user-delete)

```ruby
@client.delete_team_user(team_id, user_id)  # Input:
                                            ## team_id (string, required)
                                            ## user_id (string, required)
                                            # Output:
                                            ## Hash with "team_id" and "team_user_deleted" set to "true"
```

### Translations

[Translation attributes](https://lokalise.co/api2docs/ruby/#resource-translations)

#### Fetch translations

[Doc](https://lokalise.co/api2docs/ruby/#transition-list-all-translations-get)

```ruby
@client.translations(project_id, params = {})   # Input:
                                                ## project_id (string, required)
                                                ## params (hash)
                                                ### :disable_references (string) - whether to disable key references. Supported values are 0 and 1
                                                ### :page and :limit
                                                # Output:
                                                ## Array of translations for the project
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

## Additional Info

### Error handling

The gem may raise the following custom exceptions:

* `Lokalise::Error::BadRequest` (`400`) - the provided token or an id is incorrect
* `Lokalise::Error::Forbidden` (`403`)
* `Lokalise::Error::Locked` (`423`) - your token is used simultaneously in multiple requests
* `Lokalise::Error::NotFound` (`404`) - the provided endpoint (resource) cannot be found
* `Lokalise::Error::NotImplemented` (`501`)

### API Rate Limits

Lokalise does not [rate-limit API requests](https://lokalise.co/api2docs/ruby/#resource-rate-limits), however retain a right to decline the service in case of excessive use. Only one concurrent request per token is allowed. To ensure data consistency, it is not recommended to access the same project simultaneously using multiple tokens.

## Running Tests

1. Copypaste `.env.example` file as `.env`.
2. Put your API token inside. The `.env` file is excluded from version control so your token is safe.
3. Run `rspec .`. Observe test results and code coverage.

## License

This gem is licensed under the [MIT License](https://github.com/lokalise/ruby-lokalise-api/blob/master/LICENSE).

Copyright (c) [Lokalise team](http://lokalise.co), [Ilya Bodrov](http://bodrovis.tech)