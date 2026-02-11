---
---
# Exception handling

## Error codes

[Error codes used by the API](https://developers.lokalise.com/reference/api-errors)

The gem may raise the following custom exceptions:

* `RubyLokaliseApi::Error::BadRequest` (`400`) - the provided request incorrect
* `RubyLokaliseApi::Error::Unauthorized` (`401`) - token is missing or incorrect
* `RubyLokaliseApi::Error::Forbidden` (`403`) - authenticated user does not have sufficient rights to perform the desired action
* `RubyLokaliseApi::Error::NotFound` (`404`) - the provided endpoint (resource) cannot be found
* `RubyLokaliseApi::Error::MethodNotAllowed` (`405`) - HTTP request with the provided verb is not supported by the endpoint
* `RubyLokaliseApi::Error::NotAcceptable` (`406`) - posted resource is malformed
* `RubyLokaliseApi::Error::Conflict` (`409`) - request conflicts with another request
* `RubyLokaliseApi::Error::Locked` (`423`) - your token is used simultaneously in multiple requests
* `RubyLokaliseApi::Error::TooManyRequests` (`429`)
* `RubyLokaliseApi::Error::ServerError` (`500`)
* `RubyLokaliseApi::Error::BadGateway` (`502`)
* `RubyLokaliseApi::Error::ServiceUnavailable` (`503`)
* `RubyLokaliseApi::Error::GatewayTimeout` (`504`)

## API Rate Limits

[Access to all endpoints is limited](https://developers.lokalise.com/reference/api-rate-limits) to 6 requests per second from 14 September, 2021. This limit is applied per API token and per IP address. If you exceed the limit, a 429 HTTP status code will be returned and the corresponding exception will be raised that you should handle properly. To handle such errors, we recommend an exponential backoff mechanism with a limited number of retries. You can use [lokalise_rails backoff mechanism](https://github.com/bodrovis/lokalise_rails/blob/master/lib/lokalise_rails/task_definition/base.rb#L63) as an example.