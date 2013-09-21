require 'sinatra'
require 'sinatra/activerecord'

class Watson < Sinatra::Base
  set :database, ENV["DATABASE_URL"]

  enable :sessions
  set :session_secret, ENV["SECRET_TOKEN"] || "secret!"
  enable :logging

  register Sinatra::ActiveRecordExtension
  ActiveRecord::Base.include_root_in_json = false

  get '/' do
    "Hello, World!"
  end
end
