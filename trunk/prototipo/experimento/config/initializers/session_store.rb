# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_experimento_session',
  :secret      => 'bfa074f4d143ee8594bd68148f849133fb7e8ca52967b3cd9258de6cf91996c2e863ccf5b0125a1de9ccb3a7931e6cf01e6cf73fb287438697dd03cbf17c491a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
