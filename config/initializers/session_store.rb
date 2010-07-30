# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_datacatalog-web_session',
  :secret      => '67ecb29e22952b884276b35f5103064a74ca5585d8eebe6168f62aefe03cef92d1f64ac00e781351ff0f94adf448c6dbfeaa7a5ce2e75b70807fa4fe1baa5be0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
