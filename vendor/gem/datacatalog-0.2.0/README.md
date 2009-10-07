# Ruby Gem for the National Data Catalog API

Under heavy development.

## Installation

For now, the gem will not be packaged. Instead, install it manually:

    $ git clone git clone git://github.com/sunlightlabs/ruby-datacatalog.git 
    $ cd ruby-datacatalog
    $ rake check_dependencies
    $ rake build
    $ rake install # uses sudo
    # Or, instead of the line above:
    $ gem install pkg/datacatalog-0.1.0.gem

## Usage

    require 'rubygems'
    require 'datacatalog'

    DataCatalog.api_key = 'c40505247a5e308a24d70a0118f76534b543795b'
    
## Running Specs

We're not mocking out any of the web API calls in the specs. Instead, we expect developers who wish to run the specs to download and run a local sandbox instance of the [Data Catalog API](http://github.com/sunlightlabs/datacatalog-api), a Sinatra app:

    git clone git://github.com/sunlightlabs/datacatalog-api.git

Get the app running like any normal Sinatra app, so you can choose to use thin or Passenger or new hotness like [Unicorn](http://unicorn.bogomips.org/). Some special considerations:

1. We recommend creating a `sandbox` entry in `datacatalog-api`'s `config.yml`.
2. Run `RACK_ENV=sandbox rake db:ensure_admin` in the `datacatalog-api` project to create a super admin for the API instance.
3. Back here in `ruby-datacatalog`, use the example file in `spec/` to create your own `spec/sandbox_api.yml` with the API key of the admin and your local URI.
