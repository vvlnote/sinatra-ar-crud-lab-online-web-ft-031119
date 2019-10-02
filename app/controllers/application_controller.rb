
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
    "Hello world"
    @id = params[:id]
    @article = Article.find(params[:id])
    @article.update(title:params[:title], content:params[:content])
    @article.save
    redirect to "/articles/#{params[:id]}"
  end
  
  delete '/articles/:id' do
    Article.find(params[:id]).destroy
 
    redirect to "/articles"
  end
end
