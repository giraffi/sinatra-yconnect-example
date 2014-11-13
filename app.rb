require 'sinatra'
require 'omniauth-yahoojp'

## Thank you Sinatra Recipes !!
## Ref: http://recipes.sinatrarb.com/p/middleware/twitter_authentication_with_omniauth

configure do
  enable :sessions, :logging

  use OmniAuth::Builder do
    provider :yahoojp, ENV['YAHOOJP_KEY'], ENV['YAHOOJP_SECRET'],
    {
        scope: "openid profile email address"
    }
  end
end

helpers do
  # define a current_user method, so we can be sure if an user is authenticated
  def current_user
    !session[:uid].nil?
  end
end

before do
  # we do not want to redirect to twitter when the path info starts
  # with /auth/
  pass if request.path_info =~ /^\/auth\//
  pass if request.path_info =~ /^\/login$/

  # /auth/twitter is captured by omniauth:
  # when the path info matches /auth/twitter, omniauth will redirect to twitter
  redirect to('/login') unless current_user
end

get '/login' do
  erb :login
end

get '/auth/:name/callback' do
  # probably you will need to create a user in the database too...
  session[:uid] = env['omniauth.auth']['uid']
  # this is the main endpoint to your application
  redirect to('/')
end

get '/auth/failure' do
  # omniauth redirects to /auth/failure when it encounters a problem
  # so you can implement this as you please
end

get '/' do
  'Hello omniauth-yahoojp! Thanks Sinatra Recipes.'
end
