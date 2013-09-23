require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

require_relative "./models/User"

class Watson < Sinatra::Base
  set :database, ENV["DATABASE_URL"]

  enable :sessions
  set :session_secret, ENV["SECRET_TOKEN"] || "secret!"
  enable :logging

  register Sinatra::Flash
  register Sinatra::ActiveRecordExtension
  ActiveRecord::Base.include_root_in_json = false

  helpers do
    def partials(page, options = {})
      erb :"partials/#{page}", options.merge!(:layout => false)
    end
  end

  get '/' do
    redirect to('/signup')
  end

  get '/lists' do
    "Authenticated!"
  end

end

require_relative "./controllers/user_controller"
