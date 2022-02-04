# Changelog

## 5.0.0

* **Breaking change**: removed the `enable_compression` option. Compression is now enabled for all requests (however the API might still send uncompressed data if the body is small) and the response will be decompressed automatically.
* **New feature**: you can request and refresh OAuth 2 tokens:

```ruby
auth_client = Lokalise.auth_client 'OAUTH2_CLIENT_ID', 'OAUTH2_CLIENT_SECRET'

# Generate authentication URL:
url = auth_client.auth scope: %w[read_projects write_tasks]

# Generate a new token:
response = auth_client.token 'secret code'
access_token = response['access_token']
refresh_token = response['refresh_token']

# Refresh an expired token:
response = auth_client.refresh('YOUR_REFRESH_TOKEN')['access_token']

# Use the access token to perform requests on the user's behalf:
@client = Lokalise.oauth2_client access_token
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

* Added a new `.oauth_client` method for the `Lokalise` module. This method must be used when you're initializing a new API client with a **token obtained via OAuth 2 flow**, not by copy-pasting the token from the "Personal profile" section on Lokalise website. So in this case instead of saying `Lokalise.client`, you should do the following:

```ruby
@client = Lokalise.oauth_client("TOKEN_OBTAINED_VIA_OAUTH2", params)
```

* `params` are the same as for the `.client` method.
* Added a new `.reset_oauth_client!` method for the `Lokalise` module to reset the currently set `oauth_client`.

```ruby
Lokalise.reset_oauth_client! # effectively sets the `@oauth_client` to `nil`
```

## 4.3.1 (21-Sep-21)

* Make exception handling more solid
* Test with more recent Rubies

## 4.3.0 (15-Jul-21)

* Added support for GZip compression. It is off by default but you can enable it by setting the `:enable_compression` option to `true`:

```ruby
client = Lokalise.client('YOUR_TOKEN', enable_compression: true)
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

* Added support for [`QueuedProcess` endpoint](https://app.lokalise.com/api2docs/curl/#resource-queued-processes)
* Many resources now respond to the `reload_data` method which fetches new data from the API
* Various code improvements
* Test against more recent Rubies
* Fixed documentation links in code comments

## 2.10.0 (28-Feb-20)

* Added methods to [regenerate webhook secret](https://lokalise.com/api2docs/curl/#transition-regenerate-a-webhook-secret-patch):
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

* Added methods to [merge branches](https://lokalise.com/api2docs/curl/#transition-merge-a-branch-post):
  + `branch.merge params`
  + `client.merge_branch project_id, branch_id, params`

## 2.7.0 (30-Oct-19)

* Added [`Branch` endpoint](https://lokalise.co/api2docs/curl/#resource-branches)

## 2.6.1 (27-Sep-19)

* Update dependencies
* Update tests for the latest Faraday (0.16)

## 2.6.0 (21-Aug-19)

* Added [`Webhook` endpoint](https://lokalise.co/api2docs/curl/#resource-webhooks) (thanks to [@snkashis](https://github.com/snkashis) for help!)

## 2.5.0 (01-Aug-19)

* Added `:timeout` and `:open_timeout` options for the client [to customize request timeouts](https://github.com/lokalise/ruby-lokalise-api#setting-timeouts)
* [Added explanations](https://github.com/lokalise/ruby-lokalise-api#choosing-adapter) on how to change a default adapter

## 2.4.0 (31-Jul-19)

* Remove MultiJson dependency and allow to use a [custom JSON parser](https://github.com/lokalise/ruby-lokalise-api#customizing-json-parser)

## 2.3.0 (17-Jul-19)

* Incorporated latest API changes
* Added support for [`TranslationStatus` endpoint](https://lokalise.co/api2docs/curl/#resource-translation-statuses)

## 2.2.0 (19-May-19)

* Added support for [`TeamUserGroup` endpoint](https://lokalise.co/api2docs/curl/#resource-team-user-groups)
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
