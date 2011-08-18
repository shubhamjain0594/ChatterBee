require "bundler/setup"
require "sinatra/base"
require "pubnub"
require "mongo_mapper"
require "sass"
require "erb"
require "geocoder"
require "omniauth"
require "openssl"
require "openid/store/filesystem"

# We moved lots of helpers into a separate file. These are all things that are
# useful throughout the rest of the application.
require_relative "helpers"

# It's good form to make your Sinatra applications be a subclass of
#Sinatra::Base. This way, we're not polluting the global namespace with our
#methods and routes and such.
class Jegit < Sinatra::Base; end;

# Need to require the config so it can set up the connection to mongo
require_relative "config/config"

# Include all models and controllers
Dir.glob("controllers/*.rb").each { |r| require_relative r }
Dir.glob("models/*.rb").each { |r| require_relative r }


class Jegit < Sinatra::Base
  
  before do
    @user = User.find(session[:user_id]) || nil
    redirect to("/auth/") if auth_needed?
  end
  
  not_found do
    erb :not_found
  end
  
  error do
    erb :error
  end
  
end