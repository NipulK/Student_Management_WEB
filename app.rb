require 'bundler/setup'
require 'sinatra'
require './models/student'


set :bind, '0.0.0.0'

get '/' do
  @students = Student.all
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


