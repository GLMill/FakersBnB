# ENV['RACK_ENV'] = 'development'

require 'sinatra/base'
require_relative './lib/user'
require_relative './lib/property'
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


  get '/add_property' do
    erb :add_property
  end

  post '/property_added' do
    property = Property.create(:name => params[:property_name])
    redirect "/property_added/#{property.id}"
  end

  # post '/update-message/:id' do |id|
  #   message = Message.get!(id.to_i)
  #   message.update(:text => params[:message])
  #   redirect"/messages/#{id}"
  # end

  get '/property_added/:id' do |id|
    # we want to return the property that has the particular name, desc, price that was stored in the param when user filled the form

    @property = Property.get!(id)
    erb :property_added
  end

  run! if app_file == $0
end
