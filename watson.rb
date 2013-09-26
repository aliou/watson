require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

require_relative "./models/List"
require_relative "./models/Task"
require_relative "./models/User"

require_relative "./helpers/authentification_helpers"

class Watson < Sinatra::Base
  set :database, ENV["DATABASE_URL"]

  enable :sessions
  set :session_secret, ENV["SECRET_TOKEN"] || "secret!"
  enable :logging

  register Sinatra::Flash
  register Sinatra::ActiveRecordExtension
  ActiveRecord::Base.include_root_in_json = false

  helpers do
    include Sinatra::AuthentificationHelpers

    def partials(page, options = {})
      erb :"partials/#{page}", options.merge!(:layout => false)
    end
  end

  before do
    if !is_authenticated? && needs_autentification?(request.path)
      redirect '/signin'
    end
  end

  get '/' do
    if User.any?
      redirect to("/lists")
    else
      redirect to("/signup")
    end
  end
end

require_relative "./controllers/user_controller"
require_relative "./controllers/session_controller"
require_relative "./controllers/list_controller"
