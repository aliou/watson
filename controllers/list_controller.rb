class Watson < Sinatra::Base
  get "/lists" do
    @lists = List.all

    erb :'lists/index'
  end

  post "/lists" do
    if params.keys.include?(:name)
      List.create(:name => params[:name])
      flash.now[:success] = "List \"#{params[:name]}\" created."
    else
      flash.now[:error] = "Name not found"
    end
    erb :'lists/index'
  end

  delete "/lists/:feed_id" do
    begin
      list = List.find(params[:feed_id])
    rescue ActiveRecord::RecordNotFound
      flash.now[:error] = "You are trying to delete an unexistant list. WTF?!"
      erb :'lists/index'
    end
    list.archive!
  end
end
