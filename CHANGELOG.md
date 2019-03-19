# Changelog

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
