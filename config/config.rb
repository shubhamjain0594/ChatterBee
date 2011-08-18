require_relative "../lib/jegit/session"

class Jegit
  
  configure do
    enable :static
    enable :sessions
    set :scss, :style => :compact
    set :session_secret, "chatterbee-is-great"
  end
  
  use Jegit::Session, :secret => "zM*J*ND)@DLKJDKJGDO0jgd9e@!jhdg"
  use Rack::Timeout
  Rack::Timeout.timeout = 10
    
  use OmniAuth::Builder do
    provider :facebook, "261061570588802", "b8393cb5960916a7df9ff5954b236739"
    provider :twitter, "2I4tbMUdkYlscDnhLQhbqw", "Nw7oaPzt6HfgSS42K57BwdjwAfzLbmxnp2LOyxohws"
  end
  
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  MongoMapper.connection = Mongo::Connection.new("localhost", 27017, :pool_size => 5, :timeout => 5)
  MongoMapper.database = "jegit"
  
end