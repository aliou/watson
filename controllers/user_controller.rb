require "digest/md5"

class Watson < Sinatra::Base
  get '/signup' do
    erb :'user/signup'
  end

  post '/signup' do
    if empty?(params) or mismatch?(params)
      flash.now[:error] = "There is an error in your informations. Please try again."
      erb :"user/signup"
    else
      User.create(:mail => params[:mail],
                  :password_digest => Digest::MD5.hexdigest(params[:password]))
      redirect to('/lists')
    end
  end

  private
  def empty?(params)
    params.keys.include?(:mail).nil? or params.keys.include?(:password).nil? ||
      params.keys.include?(:password_confirmation).nil?
  end

  def mismatch?(params)
    params[:password] != params[:password_confirmation]
  end
end
