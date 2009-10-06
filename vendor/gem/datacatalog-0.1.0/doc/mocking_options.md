# Ruby wrapper API mocking options

## 1. Machinist 

* Use Machinist as an object factory for HTTParty::Response and DataCatalog::* objects.
* Big question: Can HTTParty::Response object methods be appropriately mocked out by Machinist?
* Will need to keep objects in sync with the live API

## 2. FakeWeb

* Use FakeWeb to fake out the HTTP responses
* Will need to know the details of the JSON bodies, but HTTParty wraps all that for us.
* Will need to keep the JSON output (and headers + status codes) in sync with the live API

## 3. Local Sandbox API

* Use a locally running sandbox API that mocks out the real API
* Each spec will need to build up needed objects in the API, then tear them down at the end.
* Much slower than in-memory solutions above.
* To keep in sync with live API, just need to refresh API codebase. 