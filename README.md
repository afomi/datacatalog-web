# National Data Catalog

Front-end web app.

### Requirements

Other the standard Rails stack, the biggest requirement is the National Data Catalog API, which is a Sinatra app that uses MongoDB as it's data store. Please navigate to the [datacatalog-api](http://github.com/sunlightlabs/datacatalog-api) repository to get set up on that end.

        sudo gem sources -a http://gems.github.com
        sudo gem install authlogic authlogic-oid ruby-openid nokogiri faker httparty
        sudo gem install rspec rspec-rails thoughtbot-shoulda rr
        sudo gem install notahat-machinist webrat cucumber bmabey-database_cleaner

### Setup

1. Configure `config/api.yml` to point to your API instance.
2. Configure a `config/database.yml` to point to your relational database of choice.

### Testing Stack

We're taking testing Very Seriously, practicing [outside-in development](http://dannorth.net/whats-in-a-story). Our stack:

* [Cucumber](http://github.com/aslakhellesoy/cucumber/tree) for stories (features + scenarios)
* [Webrat](http://github.com/brynary/webrat/tree/master) for acceptance tests
* [RSpec](http://wiki.github.com/dchelimsky/rspec) for unit and functional tests
* [Shoulda](http://giantrobots.thoughtbot.com/2009/2/3/speculating-with-shoulda) for macros
* [RR](http://github.com/btakita/rr/tree/master) for mocks and stubs
* [Machinist](http://github.com/notahat/machinist) for factories
* [NullDB](http://github.com/avdi/nulldb/tree/master) to make unit tests go superfast
* [SeleniumRC](http://seleniumhq.org/projects/remote-control/) for Javascript interaction tests
* [BlueRidge](http://github.com/relevance/blue-ridge/tree/master) for Javascript unit tests