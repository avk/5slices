# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_5slices_session',
  :secret      => '3b11aedfe9b7dd5677c196036a0eabc0dd14239a02ea6595e14f210489a302118c7b8c7dd3a353e2b98e802c84d71eac9e280f2c904dbb687039bed2a0140c15'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
