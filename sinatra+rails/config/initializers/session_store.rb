# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sinatra+rails_session',
  :secret      => 'f81e7a39f4b9aa1ba323dc5849568521db87cbd25d545a1d4d7a27619273429924582b83b372bfe3d42500676185bed27ead7521cb77af5dfa8568c19992380b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
