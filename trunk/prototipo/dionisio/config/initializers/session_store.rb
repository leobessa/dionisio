# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dionisio_session',
  :secret      => '1fd02c4af9293468fa790a11d6f4da2652c893ac3ddab5f535d7d7c10cacbed8c8e18aa5c559c265e828a1117ca06296c5bd5f8ff20b2480cc8f2610fa129d95'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
