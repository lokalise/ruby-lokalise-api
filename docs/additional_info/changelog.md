# Changelog

## 8.0.1 (24-Aug-2023)

* Code updates and improvements
* Add `content-type` header in certain cases

## 8.0.0 (21-Jul-2023)

In this version **SDK has been fully rewritten** to make it more robust, better tested, and even more comfortable to work with. While most of the methods have similar signatures, there are a few major changes.

**Breaking changes:**

* Method `translation_statuses` has been renamed to `custom_translation_statuses`
* Method `translation_status` has been renamed to `custom_translation_status`
* Method `create_translation_status` has been renamed to `create_custom_translation_status`
* Method `update_translation_status` has been renamed to `update_custom_translation_status`
* Method `destroy_translation_status` has been renamed to `destroy_custom_translation_status`
* Method `translation_status_colors` has been renamed to `custom_translation_status_colors`
* Method `language` has been renamed to `project_language`
* Method `create_languages` has been renamed to `create_project_languages`
* Method `update_language` has been renamed to `update_project_language`
* Method `destroy_language` has been renamed to `destroy_project_language`
* Method `destroy_all` has been removed from `Keys` collection
* Method `jwt` has been renamed to `create_jwt`:

```ruby
token = @client.create_jwt project_id, service: :ota

token.jwt # => '123abcd'
```

* `raw_data` method has been removed. All resources respond to the methods named after the corresponding attributes and also support `[]` notation. Therefore both versions should work:

```ruby
branch = @client.branch project_id, branch_id

branch.name # => 'my-branch'
branch[:name] # => 'my-branch'
```

**Updates:**

* Added many new instance methods like `update`, `destroy`, and `reload_data`.

```ruby
params = {
  lang_name: 'Updated custom language',
  plural_forms: %w[one many]
}

language = @client.project_language project_id, language_id

updated_language = language.update params

updated_language.lang_name # => 'Updated custom language'
```

* Individual projects now respond to many new methods like `merge_branch`, `restore_snapshot`, and so on. Please browse documentation for a specific endpoint to learn about new features.

```ruby
project = @client.project project_id

restored_project = project.restore_snapshot snapshot_id

restored_project.name # => 'Project copy'
```

* Methods like `destroy` now return objects, not hashes. However, these objects also respond to the `[]` method to preserve backwards compatibility.

```ruby
response = @client.destroy_screenshot project_id, screen_id
response.screenshot_deleted # => true
response[:screenshot_deleted] # => true
```

* Test only with Ruby 3+ (though the SDK should still work with version 2.7+). Next major version will require Ruby 3+.
* Use WebMock for testing instead of VCR
* Use faraday-gzip version 2 and zlib version 3

## 7.2.0 (11-Jan-2023)

* Updated the `jwt` method. It is now mandatory to provide the project ID to request JWT for:

```ruby
resp = @client.jwt("123.abcd")
resp.jwt # => 'eyJ0eXAiOi...`
```

## 7.1.1 (03-Jan-2023)

* Update dependencies and tests
* Update test matrix

## 7.1.0 (30-Nov-2022)

* Added support for the [`Jwt` endpoint](https://developers.lokalise.com/reference/get-ota-jwt). You can now request JWT easily (please note that these tokens are used only to work with OTA):

```ruby
resp = @client.jwt
resp.jwt # => 'eyJ0eXAiOi...`
```

## 7.0.0 (18-Nov-2022)

* **Breaking change**: `#token` and `#refresh` methods (used to request OAuth 2 access and refresh tokens) now return proper Ruby objects:

```ruby
RubyLokaliseApi.auth_client('client_id', 'client_secret')

# Previously:

token = auth_client.token 'oauth2_code' # this method used to return a hash

token['access_token']
token['refresh_token']

refresh = auth_client.refresh 'refresh_token' # this method used to return a hash

token['access_token']
token['expires_in']

# NOW:

token = auth_client.token 'oauth2_code' # this is an instance of the Token class

token.access_token
token.refresh_token

refresh = auth_client.refresh 'refresh_token' # this is an instance of the Refresh class

token.access_token
token.expires_in
```

* **New feature**: you can now customize timeouts when creating an Auth client (these params are optional):

```ruby
auth_client = RubyLokaliseApi.auth_client('id', 'secret', timeout: 5, open_timeout: 10)
```

* Various code tweaks

## 6.2.0 (02-Aug-2022)

**New feature**: added ability to access resources' attributes with the `[]` notation. In other words, previously you could only write:

```ruby
branch.branch_id
branch.name
```

Now you can also write:

```ruby
branch[:branch_id]
branch['name']
```

This feature was introduced so that all resources can play nicely with methods like `pluck`.

## 6.1.0 (27-Jul-2022)

* Added support for the [Delete a file endpoint](https://lokalise.github.io/ruby-lokalise-api/api/files#delete-a-file)
* Updated links to the API docs

## 6.0.0 (11-Mar-2022)

* **Breaking change**: this gem now requires Ruby 2.7 or above.
* **Breaking change**: use Zeitwerk loader and reorganized source files.
* **Breaking change**: lock JSON dependency to ~> 2.
* **Breaking change**: renamed `Lokalise` main module to `RubyLokaliseApi` and changed the way you require the gem. You can use find-replace to fix all occurences. For example, if previously you wrote:

```ruby
require 'ruby-lokalise-api'

@client = Lokalise.client 'YOUR_TOKEN_HERE'
```

Now you should say:

```ruby
require 'ruby_lokalise_api'

@client = RubyLokaliseApi.client 'YOUR_TOKEN_HERE'
```

## 5.0.0 (08-Feb-2022)

* **Breaking change**: removed the `enable_compression` option. Compression is now enabled for all requests (however the API might still send uncompressed data if the body is small) and the response will be decompressed automatically.
* **New feature**: you can [request and refresh OAuth 2 tokens](https://lokalise.github.io/ruby-lokalise-api/additional_info/oauth2):

```ruby
auth_client = RubyLokaliseApi.auth_client 'OAUTH2_CLIENT_ID', 'OAUTH2_CLIENT_SECRET'

# Generate authentication URL:
url = auth_client.auth scope: %w[read_projects write_tasks]

# Generate a new token:
response = auth_client.token 'secret code'
access_token = response['access_token']
refresh_token = response['refresh_token']

# Refresh an expired token:
response = auth_client.refresh('YOUR_REFRESH_TOKEN')['access_token']

# Use the access token to perform requests on the user's behalf:
@client = RubyLokaliseApi.oauth2_client access_token
@client.projects # list user's projects
```

* Updated to Faraday 2 and dropped a deprecated faraday_middleware dependency.

## 4.5.1 (27-Jan-22)

* Do not memorize `client` (issues with multithreading)
* Fixed docs typos (thanks, @keymastervn)
* Test with Ruby 3.1.0

## 4.5.0 (16-Dec-21)

* Added support for the [`Segments` endpoint](https://lokalise.github.io/ruby-lokalise-api/api/segments)
* Added support for the [`TeamUserBillingDetails` endpoint](https://lokalise.github.io/ruby-lokalise-api/api/team-user-billing-details)
* Test with more recent Rubies
* Various code updates

## 4.4.0 (25-Oct-21)

* Added a new `.oauth_client` method for the `Lokalise` module. This method must be used when you're initializing a new API client with a **token obtained via OAuth 2 flow**, not by copy-pasting the token from the "Personal profile" section on Lokalise website. So in this case instead of saying `RubyLokaliseApi.client`, you should do the following:

```ruby
@client = RubyLokaliseApi.oauth_client("TOKEN_OBTAINED_VIA_OAUTH2", params)
```

* `params` are the same as for the `.client` method.
* Added a new `.reset_oauth_client!` method for the `Lokalise` module to reset the currently set `oauth_client`.

```ruby
RubyLokaliseApi.reset_oauth_client! # effectively sets the `@oauth_client` to `nil`
```

## 4.3.1 (21-Sep-21)

* Make exception handling more solid
* Test with more recent Rubies

## 4.3.0 (15-Jul-21)

* Added support for GZip compression. It is off by default but you can enable it by setting the `:enable_compression` option to `true`:

```ruby
client = RubyLokaliseApi.client('YOUR_TOKEN', enable_compression: true)
```

## 4.2.0 (28-Apr-21)

* Added a `task_id` attribute for the `Translation` model
* Drop official support for Ruby 2.5 which has reached the EOL
* Minor code updates

## 4.1.0 (01-Mar-21)

* Added `payment_method` and `dry_run` attributes to `Order`

## 4.0.0 (02-Feb-21)

* **License type is now BSD 3 Clause**
* Added `auto_close_items` attribute for the `Task` endpoint
* Dependency updates
* Test against Ruby 3

## 3.1.0 (08-Jul-20)

* Added all recently introduced attributes for the following endpoints: `Contributor` and `Key`
* Better support for method chaining and data reloading
* API now supports only background file uploads, and the `queue` parameter doesn't have any effect anymore. Therefore, removed all code and docs related to sync uploading.

## 3.0.0 (18-May-20)

* **Breaking change** Uploading files in the background is now a preferred method, and the only method in version 3. Synchronous uploading is still supported and allowed in version 2 but will be removed in the near future. Find more info [in the docs](https://github.com/lokalise/ruby-lokalise-api#upload-translation-file).
* Added support for [background import](https://github.com/lokalise/ruby-lokalise-api#upload-translation-file). Background import will return a queued process with the status of the job:

```ruby
queued_process = @client.upload_file project_id,
                                     data: 'Base-64 encoded data... ZnI6DQogI...',
                                     filename: 'my_file.yml',
                                     lang_iso: 'en'

queued_process.status # => 'queued'
# ...after some time...
queued_process = queued_process.reload_data
queued_process.status # => 'finished'
```

* Added support for [`QueuedProcess` endpoint](https://developers.lokalise.com/reference/list-all-processes)
* Many resources now respond to the `reload_data` method which fetches new data from the API
* Various code improvements
* Test against more recent Rubies
* Fixed documentation links in code comments

## 2.10.0 (28-Feb-20)

* Added methods to [regenerate webhook secret](https://developers.lokalise.com/reference/regenerate-a-webhook-secret):
  + `@client.regenerate_webhook_secret(project_id, webhook_id)`
  + `webhook.regenerate_secret`
* API base URL is now `https://api.lokalise.com/api2/` instead of `https://api.lokalise.co/api2/`

## 2.9.0.1 (21-Jan-20)

* Make JSON dependency version less strict
* Test against Ruby 2.7.0

## 2.9.0 (05-Jan-20)

* Fixed a couple of bugs
* Updated Faraday to version 1

## 2.8.0 (13-Nov-19)

* Added methods to [merge branches](https://developers.lokalise.com/reference/merge-a-branch):
  + `branch.merge params`
  + `client.merge_branch project_id, branch_id, params`

## 2.7.0 (30-Oct-19)

* Added [`Branch` endpoint](https://developers.lokalise.com/reference/list-all-branches)

## 2.6.1 (27-Sep-19)

* Update dependencies
* Update tests for the latest Faraday (0.16)

## 2.6.0 (21-Aug-19)

* Added [`Webhook` endpoint](https://developers.lokalise.com/reference/list-all-webhooks) (thanks to [@snkashis](https://github.com/snkashis) for help!)

## 2.5.0 (01-Aug-19)

* Added `:timeout` and `:open_timeout` options for the client [to customize request timeouts](https://github.com/lokalise/ruby-lokalise-api#setting-timeouts)
* [Added explanations](https://github.com/lokalise/ruby-lokalise-api#choosing-adapter) on how to change a default adapter

## 2.4.0 (31-Jul-19)

* Remove MultiJson dependency and allow to use a [custom JSON parser](https://github.com/lokalise/ruby-lokalise-api#customizing-json-parser)

## 2.3.0 (17-Jul-19)

* Incorporated latest API changes
* Added support for [`TranslationStatus` endpoint](https://developers.lokalise.com/reference/list-all-statuses)

## 2.2.0 (19-May-19)

* Added support for [`TeamUserGroup` endpoint](https://developers.lokalise.com/reference/list-all-team-users)
* Enhancements to method chaining

## 2.1.1 (17-May-19)

* Incorporate API updates (new attributes, mostly creation and update timestamps)
* Remove trailing slash from request URLs
* Updated cassettes and target Rubies (for Travis)

## 2.1.0 (19-Mar-19)

* Add support for `Order`, `TranslationProvider`, and `PaymentCard` endpoints

## 2.0.1 (21-Feb-19)

* Bump dependencies
* Use more direct approach to sending `DELETE` requests with bodies. It seems like Faraday team [decided to abandon the idea of writing delete request one-liners](https://github.com/lostisland/faraday/issues/693#issuecomment-466086832), so we'll stick with another approach

## 2.0.0 (14-Dec-18)

* Major re-write of internal stuff
* Introduce method chaining
* Rename all `#delete` interface methods to `#destroy`

## 1.1.0 (11-Dec-18)

* Added methods to work with pagination (`next_page?`, `last_page?`, `prev_page?`, `first_page?`, `next_page`, `prev_page`)

## 1.0.1 (10-Dec-18)

* Fixed incorrect build

## 1.0.0 (10-Dec-18)

* Initial release
