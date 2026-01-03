require 'bundler/setup'
require 'webrick'
require 'sinatra/base'
require './models/student'
require './models/user'

require 'mongo'
require 'logger'

Mongo::Logger.logger.level = ::Logger::FATAL

DB = Mongo::Client.new(['127.0.0.1:27017'], database: 'student_web')


class App < Sinatra::Base
  use Rack::Session::Cookie,
      key: 'student.session',
      path: '/',
      secret: 'very_long_secret_key_123456789',
      expire_after: 86400

  set :bind, '127.0.0.1'
  set :port, 4567

before do
  pass if request.path_info == '/login'
  pass if request.path_info == '/logout'
  redirect '/login' unless session[:user]
end

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
