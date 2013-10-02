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

  put "/lists/:id" do
    begin
      list = List.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "List not found"
      redirect to('/lists')
    end

    list.name = params[:name] if params.keys.include?(:name)
    list.archive! if params.keys.include?(:archived_at)
    list.save

    erb :'lists/index'
  end

  delete "/lists/:id" do
    begin
      list = List.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash.now[:error] = "You are trying to delete an unexistant list. WTF?!"
      erb :'lists/index'
    end
    list.archive!
  end
end
