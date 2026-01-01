require 'bundler/setup'
require 'sinatra/base'
require './models/student'

class App < Sinatra::Base
  set :bind, '0.0.0.0'
  set :port, 4567

  get '/' do
    @students = Student.all
    erb :index
  end

  get '/search' do
    @students = Student.search(params[:q])
    erb :index
  end

  get '/new' do
    erb :new
  end

  post '/create' do
    Student.create(params[:name], params[:age])
    redirect '/'
  end

  get '/edit/:id' do
    @student = Student.find(params[:id])
    erb :edit
  end

  post '/update/:id' do
    Student.update(params[:id], params[:name], params[:age])
    redirect '/'
  end

  get '/delete/:id' do
    Student.delete(params[:id])
    redirect '/'
  end

  run! if app_file == $0
end
