require 'sinatra'

set :bind, '0.0.0.0'

students = []

get '/' do
  @students = students
  erb :index
end

get '/new' do
  erb :new
end

post '/create' do
  students << { id: Time.now.to_i, name: params[:name], age: params[:age] }
  redirect '/'
end

get '/edit/:id' do
  @student = students.find { |s| s[:id].to_s == params[:id] }
  erb :edit
end

post '/update/:id' do
  s = students.find { |x| x[:id].to_s == params[:id] }
  s[:name] = params[:name]
  s[:age] = params[:age]
  redirect '/'
end

get '/delete/:id' do
  students.reject! { |s| s[:id].to_s == params[:id] }
  redirect '/'
end
