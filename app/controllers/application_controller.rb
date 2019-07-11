require 'pry'


class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id/edit' do
    @recipe=Recipe.find(params[:id].to_i)
    erb :edit
  end

  get "/recipes/:id" do

    @recipe=Recipe.find(params["id"].to_i)
#
    erb :show

  end

  get '/recipes' do
      @recipes=Recipe.all
     erb :index
  end

  post '/recipes' do
    @recipe = Recipe.new(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    # if recipe.save
    #   redirect "/login"
    # else
    #   redirect "/failure"
    # end
    @recipe.save
    @id = @recipe.id
    redirect "/recipes/#{@id}"
  end

  patch "/recipes/:id" do

    recipenew= Recipe.find(params[:id])

    @name=params[:name]
    @ingredients=params[:ingredients]
    @cook_time=params[:cook_time]
    articlenew.update({:name => @name, :ingredients => @ingredients, :cook_time => @cook_time})
    redirect to "/recipes/#{recipenew.id}"
  end

  delete "/recipes/:id" do
    Recipe.find(params[:id]).delete
    redirect to "/recipes"
  end


end
