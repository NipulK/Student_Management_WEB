require 'bundler/setup'
require 'sinatra/base'

require './models/student'
require './models/user'

class App < Sinatra::Base
  enable :sessions
  set :session_secret, "student_secret_key"
  set :bind, '0.0.0.0'
  set :port, 4567

  before do
    redirect '/login' unless session[:user] || request.path_info == '/login'
  end

  # ---------- AUTH ----------
  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user] = user[:username]
      redirect '/'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  # ---------- STUDENT CRUD ----------
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
