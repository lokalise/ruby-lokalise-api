# Getting Started

## Installation and requirements

This gem requires [Ruby 3.0+](https://www.ruby-lang.org/en/) and [RubyGems package manager](https://rubygems.org/pages/download).

Install it by running:

    gem install ruby-lokalise-api

Use v8.0.1 if you need support for Ruby 2.7.

## Initializing the client

In order to perform API requests, you require a special token that can be obtained in your [personal profile](https://lokalise.com/profile#apitokens) (*API tokens* section).

After you've obtained the token, initialize the client:

```ruby
require 'ruby_lokalise_api'

@client = RubyLokaliseApi.client 'YOUR_TOKEN_HERE'
```

Now the `@client` can be used to perform API requests! Learn more about additional options in the [Customizing request section](#customizing-request).

## Objects and models

Individual objects are represented as instances of Ruby classes which are called *models*. Each model responds to the methods that are named after the API object's attributes. [This file](https://github.com/lokalise/ruby-lokalise-api/blob/master/lib/ruby-lokalise-api/data/resource_attributes.json) lists all objects and their methods.

Here is an example:

```ruby
project = @client.project '123'

project.name # => 'Demo project'
project.description # => 'Sample description'
project.created_by # => 12345
```

Many resources have common methods like `project_id` and `branch`:

```ruby
project_id = '123.abc'
webhook_id = '678def'

webhook = client.webhook project_id, webhook_id

webhook.project_id # => '123.abc'
webhook.branch # => 'develop'
```

Models support method chaining, meaning you can fetch a resource, update and delete it in one line:

```ruby
response = @client.project('123.abc').update(name: 'New project name').destroy

response.project_deleted # => true
```

### Reloading data

Most of the resources can be reloaded using the `#reload_data` method. This method will fetch the latest data for the resource:

```ruby
project = client.project '123.abc'

project.name # => 'Initial project name'

# do something else...

# project might be updated via UI, so load new data:
reloaded_project = project.reload_data

# now `reloaded_project` has fresh data from the API!

reloaded_project.name # => 'Updated project name'
```

## Collections of resources and pagination

Fetching (or creating/updating) multiple objects will return a *collection* of objects. To get access to the actual data, use the `#collection` method:

```ruby
project = @client.projects.collection.first # => Get the first project
project.name # => 'First project in collection'
```

Bulk fetches support [pagination](https://developers.lokalise.com/reference/api-pagination). There are two common parameters available:

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
project_id = '123.abc'

params = {
  limit: 4,
  page: 2,
  disable_references: 0
}

translations = @client.translations project_id, params # => we passed three parameters here

prev_page_translations = translations.prev_page # will load the previous page while preserving the `limit` and `disable_references` params

first_translation = prev_page_translations.first # get first translation from the collection

first_translation.translation # => 'Translation text'
```

### Cursor pagination

The [List Keys](https://developers.lokalise.com/reference/list-all-keys) and [List Translations](https://developers.lokalise.com/reference/list-all-translations) endpoints support cursor pagination, which is recommended for its faster performance compared to traditional "offset" pagination. By default, "offset" pagination is used, so you must explicitly set `pagination` to `"cursor"` to use cursor pagination.

```ruby
cursor_pagination_params = {
  pagination: 'cursor',
  cursor: 'eyIxIjozMTk3ODIzNzJ9', # The starting cursor. Optional, string
  limit: 2 # The number of items to fetch. Optional, default is 100
}

keys = @client.keys '123abcdef.01', cursor_pagination_params

keys.next_cursor? # => true
keys.next_cursor # => 'eyIxIjozMTk3ODIzNzV9'

# Request keys from the next cursor (returns `nil` if the next cursor is not available):
keys_next_cursor = keys.load_next_cursor
```

## Branching

If you are using [project branching feature](https://docs.lokalise.com/en/articles/3391861-project-branching), simply add branch name separated by semicolon to your project ID in any endpoint to access the branch. For example, in order to access `new-feature` branch for the project with an id `123abcdef.01`:

```ruby
files = @client.files '123abcdef.01:new-feature'
```