# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_productsrepository_session',
  :secret      => '17b9649d0ba9bcc727167a814022d1af10257143e452a9c6a3f32d717ab85a971f690cdd30ae17033cf33721670bd2027618bc1fb798da361b3b5250c42a502d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
