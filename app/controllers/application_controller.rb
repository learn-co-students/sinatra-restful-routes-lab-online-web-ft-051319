class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/recipes' do
    @recipes = Recipe.all
    
    if @recipes.empty?
      "Wait a sec, there aren't any recipes, let's get some recipes created."
    else
      erb :index
    end
  end
  
  get '/recipes/new' do
    erb :new
  end
  
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
 
    erb :show
  end
  
  post '/recipes' do
    @recipe = Recipe.create(params)
    #binding.pry
    redirect "/recipes/#{@recipe.id}"
  end
  
  get '/recipes/:id/edit' do
    
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end
  
  patch '/recipes/:id' do

    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end
  
  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect '/recipes'
  end


end
