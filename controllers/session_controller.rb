require "digest/md5"

class Watson < Sinatra::Base
  get '/signin' do
    erb :'user/signin'
  end

  post '/signin' do
    user = User.first

    if user.password_digest == Digest::MD5.hexdigest(params[:password])
      session[:user_id] = user.id
      redirect to("/")
    else
      flash.now[:error] = "That's the wrong password. Please Try again."
      erb :'user/signin'
    end
  end

  get '/logout' do
    flash.now[:success] = "You have logged out!"
    session[:user_id] = nil

    redirect to("/")
  end
end
