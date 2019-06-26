Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/login', to: 'login#create'
      get '/auth/spotify/callback', to: 'users#create'
    end
  end
end
