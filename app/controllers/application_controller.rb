require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :new
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts/:id/edit' do
    @post=Post.find_by(id: params[:id].to_i)
    erb :edit
  end

  delete '/posts/:id/delete' do
    @post_name = Post.find_by(id: params[:id].to_i)[:name]
    Post.find_by(id: params[:id].to_i).delete
    erb :deleted
  end

  get '/posts/:id' do
    @post=Post.find_by(id: params[:id].to_i)
    erb :post
  end

  patch '/posts/:id' do
    post=Post.find_by(id: params[:id].to_i)
    post.name = params[:name]
    post.content = params[:content]
    post.save
    redirect '/posts/'+params[:id]
  end

  post '/posts' do
    Post.create(params)
    redirect '/posts'
  end

  get '/posts' do
    @posts=Post.all
    erb :index
  end

  delete '/user/:id' do |id|
     #do something in the model
  end

  get '/clear' do
    Post.delete_all
    redirect '/posts'
  end


end
