
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end
  
  get '/articles/new' do
    
    erb :new
  end
  
  post '/articles' do
    puts params
    article = Article.create(params)
    article.save
    @articles = Article.all
    erb :index
  end
  
  get '/articles' do
    @articles = Article.all
    
    erb :index
  end
  
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end
  
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end
  
  patch '/articles/:id' do
    id = params[:id]
    new_params = {}
    old_article = Article.find(id)
    new_params[:title] = params["title"]
    new_params[:content] = params["content"]
    old_article.update(new_params)

    redirect "/articles/#{old_article.id}"
  end
  
  delete '/articles/:id' do
    Article.find(params[:id]).destroy
 
    redirect to "/articles"
  end
end
