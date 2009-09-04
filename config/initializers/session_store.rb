# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_HotSheet_session',
  :secret      => '949a198d88d45744ce6a37aa5edf5db469e80bba334fbf35e25de6e26cb17998066c32507b4c27a85b6ac0417a48ead1429f14288240633c5ca16b930633f45f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
