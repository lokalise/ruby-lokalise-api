# OAuth 2

## Setting up the client

Lokalise also provides [OAuth 2 authentication flow](http://docs.lokalise.com/en/articles/5574713-oauth-2). Let's see how to generate an OAuth 2 token. The obtained token can be used to perform API requests on behalf of a user.

First of all, you'll need to create an auth client:

```ruby
auth_client = Lokalise.auth_client 'OAUTH2_CLIENT_ID', 'OAUTH2_CLIENT_SECRET'
```

Pass your client ID and client secret.

## Generating auth URL

Next, generate an authentication URL:

```ruby
url = auth_client.auth scope: 'read_projects',
                       redirect_uri: 'http://example.com/callback',
                       state: 'random string'
```

* `scope` is a required argument. It can be a string or an array of scopes passed in the following way: `%w[write_projects write_team_groups write_tasks]`.
* `redirect_uri` is optional.
* `state` is optional as well: it can be used to prevent CSRF attacks.

The `auth` method returns a URL looking like this:

```
https://app.lokalise.com/oauth2/auth?client_id=12345&scope=read_projects
```

Your customers have to visit this URL and allow access to proceed. After allowing access, the customer will be presented with a secret code that has to be used in the following step.

## Generating OAuth 2 token

Next, call the `#token` method and pass a secret code obtained on the previous step:

```ruby
response = auth_client.token 'secret code'
```

The `response` will contain a hash with the following keys:

* `access_token` — your OAuth 2 token that can be used to send requests on the user's behalf.
* `refresh_token` — use this token to refresh an expired access token.
* `expires_in` — access token lifespan.
* `token_type` — access token type (usually, "Bearer").

## Refreshing OAuth 2 token

Once your access token expires, you can refresh it in the following way:

```ruby
response = auth_client.refresh 'YOUR_REFRESH_TOKEN'
```

The `response` will contain a hash with the following keys:

* `access_token` — your new OAuth 2 token.
* `expires_in` — access token lifespan.
* `token_type` — access token type (usually, "Bearer").

## Using OAuth 2 token

If you're using an API token obtained via OAuth 2, you must initialize the client in a slightly different way:

```ruby
require 'ruby-lokalise-api'

@client = Lokalise.oauth2_client 'YOUR_OAUTH2_ACCESS_TOKEN'
```

This is because with OAuth2 tokens, a different authorization header must be sent.

Now you can send requests on the user's behalf!