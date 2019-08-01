# Changelog

## 2.5.0 (01-Aug-19)

* Added `:timeout` and `:open_timeout` options for the client [to customize request timeouts](https://github.com/lokalise/ruby-lokalise-api#setting-timeouts)
* [Added explanations](https://github.com/lokalise/ruby-lokalise-api#choosing-adapter) on how to change a default adapter

## 2.4.0 (31-Jul-19)

* Remove MultiJson dependency and allow to use a [custom JSON parser](https://github.com/lokalise/ruby-lokalise-api#customizing-json-parser)

## 2.3.0 (17-Jul-19)

* Incorporated latest API changes
* Added support for [`TranslationStatus` endpoint](https://lokalise.co/api2docs/ruby/#resource-translation-statuses)

## 2.2.0 (19-May-19)

* Added support for [`TeamUserGroup` endpoint](https://lokalise.co/api2docs/ruby/#resource-team-user-groups)
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
