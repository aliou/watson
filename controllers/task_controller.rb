class Watson < Sinatra::Base
  get '/lists/:id' do
    begin
      @list = List.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "List not found"
      redirect to('/lists')
    end
    erb :'tasks/index'
  end
end
