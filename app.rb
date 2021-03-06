ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './lib/user'
require_relative './lib/property'
require './config/datamapper'
require 'pry'

class FakersBnB < Sinatra::Base
  set :sessions, true


  get '/' do
    erb :index
  end

  get '/signin' do
    erb :signin
  end

  post '/signin' do
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect '/profile'
    else
      redirect '/error1'
    end

  end

  get '/error1' do
    erb :error1
  end

  get '/error2' do
    erb :error2
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    user = User.create(email: params[:email], password: params[:password])
    redirect '/error2' unless user.valid?
    if user
      session[:user_id] = user.id
      redirect '/profile'
    else
      redirect '/error1'
    end
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get '/profile' do
    @user = User.get(session[:user_id])
    session[:user_id]
    erb :profile
  end


  get '/add_property' do
    erb :add_property
  end

  post '/property_added' do
    property = Property.create(:name => params[:property_name], :description => params[:property_desc], :price => params[:property_price])
    redirect "/property_added/#{property.id}"
  end


  get '/property_added/:id' do |id|
    # we want to return the property that has the particular name, desc, price that was stored in the param when user filled the form
    @property = Property.get!(id)
    erb :property_added
  end

  get '/rent_property' do
    @properties = Property.all
    erb :rent_properties
  end

  get '/individual_property/:id' do |id|
    #we want to return the property that has the same id as the property thatw as the property we clicked on
    @property = Property.get!(id)
    erb :individual_property
  end

  get '/back' do
    if session[:user_id]
      redirect '/profile'
    else
      redirect '/'
    end
  end

  run! if app_file == $0
end
