get '/' do
  erb :login
end


get '/login' do
  # Look in app/views/index.erb
  erb :login
end

post '/login' do

  if user = User.authenticate(params[:username], params[:password])
    session[:user_id] = user.id
    redirect '/dashboard'
  else
    @errors = user.errors.messages
    erb :login
  end


  # @user = User.find_by_username(params[:username])
  # redirect "/dashboard"

end

get '/new_account' do
  erb :new_account
end

post '/new_account' do  
p "The params are: "params
  user = User.create(params)
  p user.valid?
  p "*" * 99
  p "Gaby here the user is just created but not saved!"

   if user.valid? # user.save (both will work)
    p user
    p user.valid?
    user.save
    p "Gaby, here the user is saved!"
    session[:user_id] = user.id
    redirect '/dashboard'
  else
    p user.valid?
    @errors = user.errors.messages
    erb :login
  end

  # @user = User.new(params)
  # p @user
  # # user.username = params[:username]
  # # user.password = params[:password]
  # if @user.save
  #   redirect "/dashboard"
  # else
  #   "errors"
  # end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/dashboard' do
  if current_user
    erb :dashboard
  else
    redirect '/login'
  end
 
end



