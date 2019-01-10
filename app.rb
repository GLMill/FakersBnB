# ENV['RACK_ENV'] = 'development'

require 'sinatra/base'
require './lib/user'
require './config/datamapper'

class FakersBnB < Sinatra::Base



  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    # 
    # user = User.create(email: params[:email], password: params[:password])
    # p user
    # if user
    #   session[:user_id] = user.id
    #   redirect '/profile'
    # else
    #   redirect '/error1'
    # end

  end

  get '/profile' do
    erb :profile
  end

  run! if app_file == $0
end
