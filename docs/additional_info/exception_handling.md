# Exception handling

## Error codes

[Error codes used by the API](https://app.lokalise.com/api2docs/curl/#resource-errors)

The gem may raise the following custom exceptions:

* `Lokalise::Error::BadRequest` (`400`) - the provided request incorrect
* `Lokalise::Error::Unauthorized` (`401`) - token is missing or incorrect
* `Lokalise::Error::Forbidden` (`403`) - authenticated user does not have sufficient rights to perform the desired action
* `Lokalise::Error::NotFound` (`404`) - the provided endpoint (resource) cannot be found
* `Lokalise::Error::MethodNotAllowed` (`405`) - HTTP request with the provided verb is not supported by the endpoint
* `Lokalise::Error::NotAcceptable` (`406`) - posted resource is malformed
* `Lokalise::Error::Conflict` (`409`) - request conflicts with another request
* `Lokalise::Error::Locked` (`423`) - your token is used simultaneously in multiple requests
* `Lokalise::Error::TooManyRequests` (`429`)
* `Lokalise::Error::ServerError` (`500`)
* `Lokalise::Error::BadGateway` (`502`)
* `Lokalise::Error::ServiceUnavailable` (`503`)
* `Lokalise::Error::GatewayTimeout` (`504`)

## API Rate Limits

[Access to all endpoints is limited](https://app.lokalise.com/api2docs/curl/#resource-rate-limits) to 6 requests per second from 14 September, 2021. This limit is applied per API token and per IP address. If you exceed the limit, a 429 HTTP status code will be returned and the corresponding exception will be raised that you should handle properly. To handle such errors, we recommend an exponential backoff mechanism with a limited number of retries. You can use [lokalise_rails backoff mechanism](https://github.com/bodrovis/lokalise_rails/blob/master/lib/lokalise_rails/task_definition/base.rb#L63) as an example.

Only one concurrent request per token is allowed.
