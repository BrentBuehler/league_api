Rails.application.routes.draw do
  get '/leagues/nearby/', to: 'leagues#nearby'
  post '/leagues', to: 'leagues#create'
end
